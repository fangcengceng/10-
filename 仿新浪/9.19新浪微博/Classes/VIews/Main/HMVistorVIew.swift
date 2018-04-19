//
//  HMVistorVIew.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/21.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class HMVistorVIew: UIView {
    
    //注册回调闭包
    var loginAndRegisterClosure: (()->())?
    
    
    //添加子控件,懒加载
   private lazy var cycleImage: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    private lazy var maskImage: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    private lazy var houseImage: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    //文字label
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        //  多行显示
        label.numberOfLines = 0
        return label
    }()
    //登陆按钮
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("登陆", for: .normal)
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        button.setTitleColor(UIColor.orange, for: .highlighted)
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    //注册按钮
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("注册", for: .normal)
         button.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        button.setTitleColor(UIColor.orange, for: .highlighted)
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    //重写初始化方法
    override init(frame: CGRect) {
         super.init(frame: frame)
        setupUI()
    }
    //如果是加载Xib来的，报错误信息
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   //界面搭建
    private  func setupUI() {
             //添加子控件
               backgroundColor = UIColor(white: 237 / 255, alpha: 1)
               addSubview(cycleImage)
        addSubview(maskImage)
        addSubview(houseImage)
        addSubview(loginButton)
        addSubview(registerButton)
        addSubview(textLabel)
        

              //约束,旋转视图
            cycleImage.translatesAutoresizingMaskIntoConstraints = false
            addConstraint(NSLayoutConstraint(item: cycleImage, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
             addConstraint(NSLayoutConstraint(item: cycleImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            
        //遮罩视图
        maskImage.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: maskImage, attribute: .centerX, relatedBy: .equal, toItem: cycleImage, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: maskImage, attribute: .centerY, relatedBy: .equal, toItem: cycleImage, attribute: .centerY, multiplier: 1, constant: 0))
        //小房子视图
        houseImage.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: houseImage, attribute: .centerX, relatedBy: .equal, toItem: cycleImage, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: houseImage, attribute: .centerY, relatedBy: .equal, toItem: cycleImage, attribute: .centerY, multiplier: 1, constant: 0))
        
        //登陆按钮
        loginButton.translatesAutoresizingMaskIntoConstraints = false
             addConstraint(NSLayoutConstraint(item: loginButton, attribute: .left, relatedBy: .equal , toItem: cycleImage, attribute: .left, multiplier: 1, constant: -20))
        
            addConstraint(NSLayoutConstraint(item: loginButton, attribute: .right, relatedBy: .equal, toItem: cycleImage, attribute: .left, multiplier: 1, constant: 40))
            addConstraint(NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: cycleImage, attribute: .bottom, multiplier: 1, constant: 70))
        //注册按钮
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .top, relatedBy: .equal , toItem: loginButton, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton
            , attribute: .right, relatedBy: .equal, toItem: cycleImage, attribute: .right, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: registerButton
            , attribute: .left, relatedBy: .equal, toItem: cycleImage, attribute: .right, multiplier: 1, constant: -40))
        
        //文字标签
       textLabel.snp_makeConstraints { (make) in
        textLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(cycleImage)
            make.top.equalTo(cycleImage.snp_bottom)
            make.width.equalTo(224)
        }

        }
        
    }
    
  //修改访客视图的信息

    func  updateVisitorInfo(text:String?,imgeName:String?) {
        if let tex = text, let imagename = imgeName{
            //执行到此，表示是消息，发现，我的控制器
            textLabel.text = tex
            houseImage.image = UIImage(named: imagename)
            cycleImage.isHidden = true
        }else{
            //执行动画
            cycleAnimation()
            
        }
        
    }
    
    //动画方法
   private func cycleAnimation() {
        let anmi = CABasicAnimation(keyPath: "transform.rotation")
    anmi.toValue = M_PI * 2
   
    anmi.repeatDuration = 20
     anmi.repeatCount = MAXFLOAT
    anmi.isRemovedOnCompletion = false
    //添加动画
    cycleImage.layer.add(anmi, forKey: nil)
  
    }
    
    
    //登陆按钮的点击事件
    func loginAction()  {
        loginAndRegisterClosure!()
    }
    //注册按钮的点击事件
    func registerAction()  {
        loginAndRegisterClosure!()
    }

    //END
}
