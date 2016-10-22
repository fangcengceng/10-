//
//  HMStatusRetweetView.swift
//  Weibo20
//
//  Created by HM on 16/9/23.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit
//  转发微博视图
class HMStatusRetweetView: UIView {
    
    //  记录转发微博底部约束
    var retweetViewBottomConstraint: Constraint?
    
    var statusViewModel: HMStatusViewModel? {
        didSet {
            contentLabel.text = statusViewModel?.retweetContent
            //  绑定转发微博配图
            //pictureView.picUrls = statusViewModel?.status?.retweeted_status?.pic_urls
            
            //  卸载上次约束
            retweetViewBottomConstraint?.uninstall()
            
            if let picUrls = statusViewModel?.status?.retweeted_status?.pic_urls, picUrls.count > 0 {
                //  表示有配图, 显示配图,更新约束,绑定数据
                pictureView.isHidden = false
                self.snp_updateConstraints(closure: { (make) in
                    retweetViewBottomConstraint = make.bottom.equalTo(pictureView).offset(HMHomeTableViewCellMargin).constraint
                })
                //  绑定数据
                pictureView.picUrls = picUrls
                
                
            } else {
                //  表示没有配图 , 隐藏配图, 更新约束
                pictureView.isHidden = true
                
                self.snp_updateConstraints(closure: { (make) in
                    retweetViewBottomConstraint = make.bottom.equalTo(contentLabel).offset(HMHomeTableViewCellMargin).constraint
                })
                
                
            }
            
        
            
            
            
            
        }
    }

    //  MARK: --    懒加载
    private lazy var contentLabel: UILabel = {
        let label = UILabel(textColor: UIColor.lightGray, fontSize: 13)
        //  多行显示
        label.numberOfLines = 0
        
        label.text = "哈哈哈 , 新浪微博, 我来了~"
        return label
    
    }()
    
    //  配图
    private lazy var pictureView: HMStatusPictureView = {
        let view = HMStatusPictureView()
        //  设置转发配图颜色等于转发微博视图颜色
        view.backgroundColor = self.backgroundColor
        
        return view
    
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //  添加控件设置约束
    private func setupUI() {
    
        
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        addSubview(contentLabel)
        addSubview(pictureView)
        
        contentLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(HMHomeTableViewCellMargin)
            make.leading.equalTo(self).offset(HMHomeTableViewCellMargin)
            make.width.equalTo(ScreenWidth - 2 * HMHomeTableViewCellMargin)
        }
        
        pictureView.snp_makeConstraints { (make) in
            make.leading.equalTo(contentLabel)
            make.top.equalTo(contentLabel.snp_bottom).offset(HMHomeTableViewCellMargin)
          
        }
        
        
        //  关键约束 -> 指定当前视图的底部约束=转发微博内容底部的约束+间距
        self.snp_makeConstraints { (make) in
            retweetViewBottomConstraint = make.bottom.equalTo(pictureView).offset(HMHomeTableViewCellMargin).constraint
        }
        
    
    }
    
    
    
   

}
