//
//  StdViewController.swift
//  AsyncTable
//
//  Created by Goro Otsubo on 2014/10/20.
//  Copyright (c) 2014年 Goro Otsubo. All rights reserved.
//

import UIKit



class StdViewController: UIViewController {
    
    var imageArray:[UIImageView]
    var textArray:[UILabel]
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
        //ここでViewの作成を行う->main threadをブロックしてしまう
        super.loadView()
        let vSize = self.view.frame.size
        
        scrollView.frame = CGRectMake(0,0,vSize.width,vSize.height)
        scrollView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(scrollView)
        
        var lowerY:CGFloat = 0
        
        for i in 0...ViewCount.no{
            
            //子猫のイメージを作る
            let imageSize = 80+i
            
            let url = NSURL.URLWithString("http://placekitten.com/g/\(imageSize)/\(imageSize)")
            let imageView = UIImageView()
            imageView.backgroundColor = UIColor.purpleColor()
            
            imageArray += [imageView]
            
            //イメージのダウンロードにSDWebImageを使う
            SDWebImageDownloader.sharedDownloader().downloadImageWithURL(url,
                options: SDWebImageDownloaderOptions.IgnoreCachedResponse,
                progress: nil,
                completed: {[weak self] (image, data, error, finished) in
                    if let wSelf = self {
                        // do what you want with the image/self
                        if(image != nil){
                            imageView.image = image
                        }
                    }
            })
            
            //文字列表示を作る
            let textView = UILabel()
            textView.numberOfLines = 0
            let attrString = NSAttributedString(
                string: ViewController.getCatText(i),
                attributes: NSDictionary(
                    object: UIFont(name: "Arial", size: 12.0),
                    forKey: NSFontAttributeName))
            textView.attributedText = attrString
            let tSize = textView.sizeThatFits(vSize)
            textArray  += [textView]
            
            imageView.frame = CGRectMake(0,lowerY,CGFloat(imageSize),CGFloat(imageSize))
            lowerY += CGFloat(imageSize)
            
            textView.frame = CGRectMake(0,lowerY,tSize.width,tSize.height)
            lowerY += tSize.height
            
            scrollView.addSubview(imageView)
            scrollView.addSubview(textView)
        }
        scrollView.contentSize = CGSizeMake(vSize.width,lowerY)
    }
    
}
