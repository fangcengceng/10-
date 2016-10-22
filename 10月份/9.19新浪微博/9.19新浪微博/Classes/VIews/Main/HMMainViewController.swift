//
//  HMMainViewController.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/19.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class HMMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    //添加中间的加号按钮，采用OC的动态的方法
//        self.tabBar = HMTabBar()//这是一个只读属性，不能赋值，如果赋值的话，以后啊滴啊用OCde 机制
        
                let addtabbar = HMTabBar()
                setValue(addtabbar, forKey: "tabBar")//key值是一个属性
        //执行闭包,要使用弱引用
        addtabbar.addclosure = { [weak self] in
            print("我是闭包传递过来的")
        }
        //执行代理
        addtabbar.hmDelegate = self
        
        //将图片颜色修改为图片本身的颜色，方法有两种：一种是设置图片的渲染模式，一种是设置tabbar 的属性
//        UITabBar.appearance().tintColor = UIColor.orange

        
        //添加子视图
        addChildViewController(childController:HMHomeTableViewController(), title: "首页", imageName: "tabbar_home")
        
        addChildViewController(childController: HMDiscoverViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(childController: HMMessageViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(childController: HMProfilesViewController(), title: "我的", imageName: "tabbar_profile")

    }

    //重载添加子视图的方法
    func addChildViewController(childController: UIViewController,title: String,imageName: String) {
        
//        //添加带文字的图片,前提是UI给的是图文一体的图片
//        if(title == "我的"){
//            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
//            
//        }else{
//            childController.tabBarItem.title = title
//            childController.navigationItem.title = title
//            childController.title = title
//            
//            
//        }
        
        //        childController.tabBarItem.title = title //默认字体颜色与大小

      //设置字体大小和选中的
        childController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .selected)
        childController.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.boldSystemFont(ofSize: 14)], for: .normal)
        
        //设置图片
        childController.tabBarItem.image = UIImage.init(named: imageName)
        childController.tabBarItem.selectedImage = UIImage.init(named: "\(imageName)_selected")?.withRenderingMode(.alwaysOriginal)
        //设置导航条标题，并且将其包成nav
        childController.title = title
        let nav = HMNavViewController.init(rootViewController: childController)
        
        addChildViewController(nav)
    }

    
    
    
    
}
extension HMMainViewController:HMTabBarDelegate{
    //执行代理方法
    func didSelectedAddButton() {
        print("我是代理传递过来的")
    }
}
