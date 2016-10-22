//
//  HMVistorTableViewController.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/21.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class HMVistorTableViewController: UITableViewController {
    
    var isloging:Bool = HMHMUseraccountViewModel.shareduserAccountViewModel.isLogin
    var visitorView: HMVistorVIew?
    //自定义视图控制器
    override func loadView() {
        if isloging{
            super.loadView()
        }else{
            //否则提供自定义视图
             visitorView = HMVistorVIew()
            //回调访客视图闭包,跳转到新浪注册按钮,注意循环引用
            visitorView?.loginAndRegisterClosure = { [weak self] in
                self?.sinaregisterVC()
                
            }
            view = visitorView
            setupNav()
        }
        
    }
    
    private  func setupNav(){
//        设置左侧的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "登陆", target: self, action: #selector(loginAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", target: self, action: #selector(loginAction))
    }

    func  loginAction() {
        
        print("你点击了visitor控制器的登陆按钮")
        
    }
    

   override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
   private func sinaregisterVC() {
       let sinavc = HMHMOAuthViewController()
    //如果直接push，会调用自定义的navcontrller,我们需要的是系统提供的,如果只是present 就没有导航栏，无法返回
    let nav = UINavigationController(rootViewController: sinavc)
       present(nav, animated: true, completion: nil)
    
    }
    
    //END
}
