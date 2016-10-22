//
//  UIBarButtonItem+Extention.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/19.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit


extension UIBarButtonItem{
    //创建遍历构造函数
    convenience init(title: String,imageName:String? = nil, target:Any?, action:Selector) {
        //调用父类的
        self.init()
        //创建一个button 
        let button = UIButton()
       // button .addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        if imageName != nil{
            button.setImage(UIImage(named:imageName!), for: .normal)
        }
        //设置字体颜色和大小
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitleColor(UIColor.orange, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        customView = button
        button.sizeToFit()
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func buttonAction() {
        
        print("我是barbutton分类来的")
    }
    
    
}
