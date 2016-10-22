//
//  HMWelcomViewController.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/26.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit
import SDWebImage
    let iconWidth:CGFloat = 85
class HMWelcomViewController: UIViewController {

    //背景图
    private lazy var bjImageView: UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    //头像占位图
    private lazy var iconImageView: UIImageView = {
        
        let iconview = UIImageView(image: UIImage(named: "avatar_default_big"))
        //保证imgeUrl不为空
        if let imageUrl = HMHMUseraccountViewModel.shareduserAccountViewModel.userAccount?.avatar_large {
            
        iconview.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "avatar_default_big"))
   
        }
        
    
        
        iconview.layer.cornerRadius = iconWidth * 0.5
        iconview.layer.masksToBounds = true
        return iconview
        
    }()
    //文字信息
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        
        if let name = HMHMUseraccountViewModel.shareduserAccountViewModel.userAccount?.name {
            label.text = "欢迎回来\(name)"
        }else{
            label.text = "欢迎回来"
        }
        
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.alpha = 0
        return label
    }()
    
    
    
    //自定义视图
    override func loadView() {
      view = bjImageView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       
        
    }
    //界面搭建
    func setupUI() {

        view.addSubview(iconImageView)
        view.addSubview(textLabel)
        
        iconImageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(200)
            make.size.equalTo(CGSize(width:iconWidth, height: iconWidth))
        }
        
        textLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(iconImageView)
            make.top.equalTo(iconImageView.snp_bottom).offset(10)
            
        }
        
    }
    
    //弹簧动画
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        iconImageView.snp_updateConstraints { (make) in
            make.top.equalTo(view).offset(100)
        }
       UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: { 
        self.view.layoutIfNeeded()
        }) { (_) in
            UIView.animate(withDuration: 1, animations: { 
                self.textLabel.alpha = 1
                }, completion: { (_) in
                    //完成切换页面到首页
                    NotificationCenter.default.post(name: NSNotification.Name(switchRootVCNotification), object: nil)
     
                    
            })
            
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
   
}
