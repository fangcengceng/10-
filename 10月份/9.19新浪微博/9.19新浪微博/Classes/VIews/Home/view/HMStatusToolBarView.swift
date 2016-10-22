
//
//  HMStatusToolBarView.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/26.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class HMStatusToolBarView: UIView {
    //使用viewModel绑定数据
    var statusViewModel: HMStatsViewModel?{
        didSet{
            retweenButton.setTitle(statusViewModel?.retweentCountContent, for: .normal)
            commentButton.setTitle(statusViewModel?.commentCountContent, for: .normal)
            unlikeButton.setTitle(statusViewModel?.unlikeCountContent, for: .normal)
            
        }
        
    }
    
   
    private lazy var retweenButton: UIButton = self.addChildButton(imagename: "timeline_icon_retweet", title: "转发")
    private lazy var commentButton: UIButton = self.addChildButton(imagename: "timeline_icon_comment", title: "评论")
    private lazy var unlikeButton: UIButton = self.addChildButton(imagename: "timeline_icon_unlike", title: "赞")
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //界面搭建
    func setupUI() -> () {
      
        //分割线
         let firstImageView = addChildLineView()
        let sencondImageView = addChildLineView()
 
//约束
        //转发
        retweenButton.snp_makeConstraints { (make) in
            make.top.leading.bottom.equalTo(self)
            make.width.equalTo(commentButton)
        }
        //评论
        commentButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(retweenButton.snp_trailing)
            make.width.equalTo(unlikeButton)
            
        }
        //赞
        unlikeButton.snp_makeConstraints { (make) in
            make.top.trailing.bottom.equalTo(self)
            make.leading.equalTo(commentButton.snp_trailing)
        }
        
        firstImageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(retweenButton.snp_trailing)
            make.centerY.equalTo(self)
        }
        
        sencondImageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(unlikeButton.snp_leading)
            make.centerY.equalTo(self)
        }
        
        
        
    }
    
    //按钮的函数
    func addChildButton(imagename: String,title: String) ->UIButton{
        let button = UIButton()
        button.setImage(UIImage(named:imagename), for: .normal)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        //背景图片
        button.setBackgroundImage(UIImage(named: "timeline_card_bottom_background"), for: .normal)
        //去掉高亮状态
        button.adjustsImageWhenHighlighted = false
        //将按钮添加到tool上
        addSubview(button)
        return button
    }
    
    func addChildLineView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "timeline_card_bottom_line"))
        addSubview(imageView)
        return imageView
        
        
    }

}
