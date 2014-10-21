//
//  AsyncViewController.swift
//  AsyncTable
//
//  Created by Goro Otsubo on 2014/10/21.
//  Copyright (c) 2014年 Goro Otsubo. All rights reserved.
//

import UIKit

class AsyncViewController: UIViewController {
    
    var imageArray:[ASImageNode]
    var textArray:[ASTextNode]
    let scrollView = UIScrollView()
    
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        imageArray = []
        textArray = []
        super.init(nibName:nil, bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let vSize = self.view.frame.size
        
        //scrollViewは素直につけましょう
        scrollView.frame = CGRectMake(0,0,vSize.width,vSize.height)
        scrollView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(scrollView)
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            
            //作成・配置は別スレッドで行う
            self.prepareViewParts()
            
            dispatch_async(dispatch_get_main_queue()) {
                //addSubviewするところはメインスレッドで実施
                self.attachViewParts()
            }
        })
    }
    
    func prepareViewParts() {
        let vSize = self.view.frame.size
        var lowerY:CGFloat = 0

        for i in 0...ViewCount.no{
            let imageSize = 80+i
            
            let url = NSURL(string:"http://placekitten.com/g/\(imageSize)/\(imageSize)")
            let imageNode = ASImageNode()
            imageNode.backgroundColor = UIColor.purpleColor()
            
            imageArray += [imageNode]
            SDWebImageDownloader.sharedDownloader().downloadImageWithURL(url,
                options: SDWebImageDownloaderOptions.IgnoreCachedResponse,
                progress: nil,
                completed: {[weak self] (image, data, error, finished) in
                    if let wSelf = self {
                        // do what you want with the image/self
                        if(image != nil){
                            if(imageNode.nodeLoaded){
                                dispatch_sync(dispatch_get_main_queue()) {
                                    // once the node's view is loaded, the node should only be used on the main thread
                                    //この分岐をいれないとExceptionが発生する
                                    imageNode.image = image
                                    }
                            }
                            else{
                                imageNode.image = image
                            }
                        }
                    }
            })
            
            let textNode = ASTextNode()
            let attrString = NSAttributedString(
                string: ViewController.getCatText(i),
                attributes: NSDictionary(
                    object: UIFont(name: "Arial", size: 12.0)!,
                    forKey: NSFontAttributeName))
            textNode.attributedString = attrString
            let tSize = textNode.measure(vSize)
            textArray  += [textNode]
            
            imageNode.frame = CGRectMake(0,lowerY,CGFloat(imageSize),CGFloat(imageSize))
            lowerY += CGFloat(imageSize)
            
            textNode.frame = CGRectMake(0,lowerY,tSize.width,tSize.height)
            lowerY += tSize.height
            
        }
    }

    func attachViewParts()
    {
        for imageNode in imageArray{
            scrollView.addSubview(imageNode.view)
        }
        var lowerY:CGFloat = 0
        
        for textNode in textArray{
            scrollView.addSubview(textNode.view)
            lowerY = max(lowerY, textNode.frame.maxY)
        }
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width,lowerY)
    }
}
