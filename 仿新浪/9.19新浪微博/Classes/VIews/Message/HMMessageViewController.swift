//
//  HMMessageViewController.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/19.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class HMMessageViewController: HMVistorTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !isloging{
            visitorView?.updateVisitorInfo(text: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知", imgeName: "visitordiscover_image_message")
        }
        
        
    }
    
   
    
//END
}
