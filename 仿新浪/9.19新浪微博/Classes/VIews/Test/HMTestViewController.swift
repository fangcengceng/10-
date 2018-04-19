//
//  HMTestViewController.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/21.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class HMTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        addRightItem()
        
    }
    
    //添加右侧的push按钮,左侧的我的按钮
    func addRightItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "push", target: self, action: #selector(pushAction))
        
    }
    //右侧的push 按钮
    func pushAction() {
        
     
        print("我是test控制器push出来的")
        let nextvc = HMTestViewController()
        //push 出来同一个控制器的新对象，不会有递归，递归是一出现就自己调用自己，是无限循环
        navigationController?.pushViewController(nextvc, animated: true)
        
    }
    
 //END
}
