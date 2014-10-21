//
//  ViewController.swift
//  AsyncTable
//
//  Created by Goro Otsubo on 2014/10/20.
//  Copyright (c) 2014年 Goro Otsubo. All rights reserved.
//

import UIKit

struct ViewCount {
    static var no = 100
}

class ViewController: UIViewController {
    //最初に表示される画面。他のビューを呼び出すボタンが二つ並んでいるだけ

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        //UIViewを使ったControllerを呼び出すボタンの作成
        var ubutton = UIButton(frame: CGRectMake(10, 100, 200, 50))
        ubutton.backgroundColor = UIColor.cyanColor()
        ubutton.addTarget(self, action: "uiviewTrans:", forControlEvents:.TouchUpInside)
        ubutton.setTitle("UIView",forState:.Normal)
        self.view.addSubview(ubutton)

        
        //AsyncDisplayNodeを使ったControllerを呼び出すボタンの作成
        var abutton = UIButton(frame: CGRectMake(10, 200, 200, 50))
        abutton.backgroundColor = UIColor.blueColor()
        abutton.addTarget(self, action: "anodeTrans:", forControlEvents:.TouchUpInside)
        abutton.setTitle("AsyncNode",forState:.Normal)
        self.view.addSubview(abutton)

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //UIViewを使ったControllerに遷移
    func uiviewTrans(sender: UIButton){
        var vctrl = StdViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(vctrl, animated: true)
    }
    


    //AsyncDisplayNodeを使ったControllerに遷移
    func anodeTrans(sender: UIButton){
        var vctrl = AsyncViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(vctrl, animated: true)
    }

    
    //ダミーテキスト作成・アクセス用関数
    class func getCatText(index:Int)->String{
        
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var placeholders : [String]? = nil
        }
        
        dispatch_once(&Static.onceToken) {
            Static.placeholders = [
                "Kitty ipsum dolor sit amet, purr sleep on your face lay down in your way biting, sniff tincidunt a etiam fluffy fur judging you stuck in a tree kittens.",
                "Lick tincidunt a biting eat the grass, egestas enim ut lick leap puking climb the curtains lick.",
                "Lick quis nunc toss the mousie vel, tortor pellentesque sunbathe orci turpis non tail flick suscipit sleep in the sink.",
                "Orci turpis litter box et stuck in a tree, egestas ac tempus et aliquam elit.",
                "Hairball iaculis dolor dolor neque, nibh adipiscing vehicula egestas dolor aliquam.",
                "Sunbathe fluffy fur tortor faucibus pharetra jump, enim jump on the table I don't like that food catnip toss the mousie scratched.",
                "Quis nunc nam sleep in the sink quis nunc purr faucibus, chase the red dot consectetur bat sagittis.",
                "Lick tail flick jump on the table stretching purr amet, rhoncus scratched jump on the table run.",
                "Suspendisse aliquam vulputate feed me sleep on your keyboard, rip the couch faucibus sleep on your keyboard tristique give me fish dolor.",
                "Rip the couch hiss attack your ankles biting pellentesque puking, enim suspendisse enim mauris a.",
                "Sollicitudin iaculis vestibulum toss the mousie biting attack your ankles, puking nunc jump adipiscing in viverra.",
                "Nam zzz amet neque, bat tincidunt a iaculis sniff hiss bibendum leap nibh.",
                "Chase the red dot enim puking chuf, tristique et egestas sniff sollicitudin pharetra enim ut mauris a.",
                "Sagittis scratched et lick, hairball leap attack adipiscing catnip tail flick iaculis lick.",
                "Neque neque sleep in the sink neque sleep on your face, climb the curtains chuf tail flick sniff tortor non.",
                "Ac etiam kittens claw toss the mousie jump, pellentesque rhoncus litter box give me fish adipiscing mauris a.",
                "Pharetra egestas sunbathe faucibus ac fluffy fur, hiss feed me give me fish accumsan.",
                "Tortor leap tristique accumsan rutrum sleep in the sink, amet sollicitudin adipiscing dolor chase the red dot.",
                "Knock over the lamp pharetra vehicula sleep on your face rhoncus, jump elit cras nec quis quis nunc nam.",
                "Sollicitudin feed me et ac in viverra catnip, nunc eat I don't like that food iaculis give me fish."]
        }
        let modIndex = index % Static.placeholders!.count
        
        return Static.placeholders![modIndex]
    }
}

