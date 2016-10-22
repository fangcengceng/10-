//
//  HMTabBar.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/19.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit
//方法二，通过代理，让控制器去做事情
protocol HMTabBarDelegate:NSObjectProtocol {
  //代理方法
    func didSelectedAddButton()
    
}
class HMTabBar: UITabBar {
   
  //定义代理对象
    weak var hmDelegate: HMTabBarDelegate?

    //方法一，通过创建闭包，让控制器去做事情
    var addclosure: (()->())?
    
    //懒加载创建底部的记号按钮
    lazy var customButton: UIButton = {
        let button = UIButton()
        //按钮的点击，让控制器去push,有闭包，代理
        button.addTarget(self, action: #selector(clickaddButton), for: .touchUpInside)
        
        
        
        //按钮图片
        button.setImage(UIImage(named:"tabbar_compose_icon_add"), for: .normal)
        button.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted") , for: .highlighted)
        //背景图片
        button.setBackgroundImage(UIImage(named:"tabbar_compose_button"), for: .normal)
        button.setBackgroundImage(UIImage(named:"tabbar_compose_button_highlighted"), for: .highlighted)
        button.sizeToFit()

        return button
    }()
    
    //中间按钮的点击事件
    func clickaddButton(){
        //执行闭包
        addclosure!()
        //执行代理
       hmDelegate?.didSelectedAddButton()
    }
    
    
    //重写构造方法
    override init(frame: CGRect) {
        //调用一下父类的方法
        super.init(frame: frame)
        setupUI()
    }
    //重写加载方法
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    //添加子控件的主方法，设置为私用的
     private  func setupUI() {
        addSubview(customButton)
         backgroundImage = UIImage(named: "tabbar_background")
        
     }
    
    //让自定义按钮居中
    override func layoutSubviews() {
      super.layoutSubviews()
        //设置按钮的中心点
        customButton.center.x = frame.size.width*0.5
        customButton.center.y = frame.size.height*0.5
        //计算每个控件的宽度
        let itemWidth = frame.size.width*0.2
        //记录遍历到的是第几个控件的索引
        var index = 0
        
        //遍历控件
        for value in subviews{
            
            if value.isKind(of: NSClassFromString("UITabBarButton")!){
                value.frame.size.width = itemWidth
                value.frame.origin.x = CGFloat(index)*itemWidth
                index += 1
                //如果是第二个按钮，预留出来位置给加号anniu
                if index == 2{
                    index += 1
                }
            }
            
        }
        
    }

}
