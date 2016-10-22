//
//  HMReteenView.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/26.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class HMReteenView: UIView {

    var retweenViewBottonConstrait: Constraint?
    
    //给各个子空间的数据的处理
    var statusViewModel: HMStatsViewModel?{
        didSet{
            contentLabel.text = statusViewModel?.retweentContent
           pictureView.picUrls = statusViewModel?.status?.retweeted_status?.pic_urls
            retweenViewBottonConstrait?.uninstall()
                       
            if let picUrls = statusViewModel?.status?.retweeted_status?.pic_urls, picUrls.count > 0{
                pictureView.isHidden = false
                self.snp_updateConstraints(closure: { (make) in
                  retweenViewBottonConstrait = make.bottom.equalTo(pictureView).offset(childViewMargin).constraint
                    
                })
                //绑定数据
                pictureView.picUrls = picUrls
            } else {
                pictureView.isHidden = true
                self.snp_updateConstraints(closure: { (make) in
                    retweenViewBottonConstrait = make.bottom.equalTo(contentLabel).offset(childViewMargin).constraint
                })
            }
            
        }
    }
   //转发配图
    private lazy var pictureView:HMStatusPictureView = {
        let view = HMStatusPictureView()
        return view
    }()
    
    //转发内容
    private lazy var contentLabel: UILabel = {
        let label = UILabel(fontsize: 13, textclor: UIColor.lightGray)
        label.text = "哈哈哈哈哈回复"
        label.numberOfLines = 0
        return label
    
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //界面搭建
    private func setupUI() {
        addSubview(contentLabel)
        addSubview(pictureView)
        //配图约束
        pictureView.snp_makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp_bottom)
            make.leading.equalTo(contentLabel)

        }
        
        //转发内容约束
        contentLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(childViewMargin)
            make.leading.equalTo(self).offset(childViewMargin)
            make.width.equalTo(screenWidth - 2 * childViewMargin)
        }
        
        //关键约束
        self.snp_makeConstraints { (make) in
           retweenViewBottonConstrait = make.bottom.equalTo(pictureView.snp_bottom).offset(childViewMargin).constraint
            
        }
        
        
    }

}
