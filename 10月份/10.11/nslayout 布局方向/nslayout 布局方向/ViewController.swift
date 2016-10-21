//
//  ViewController.swift
//  nslayout 布局方向
//
//  Created by codygao on 16/10/11.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let redView = UIView()
        redView.backgroundColor = UIColor.redColor()
        view.addSubview(redView)

        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: redView, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 0))
        
         view.addConstraint(NSLayoutConstraint(item: redView, attribute:.Right , relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: redView, attribute:.Top , relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: redView, attribute: .Bottom , relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0))

        
        
    }
    
    
    
    
    

}

