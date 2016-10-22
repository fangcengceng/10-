//
//  HMHomeTableViewCell.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/26.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit
 //子控件之间 的间距
let childViewMargin: CGFloat = 10

class HMHomeTableViewCell: UITableViewCell {
   
    //记录当前toolBar顶部约束
    var toolBarTopConstraint: Constraint?

    var statusViewModel: HMStatsViewModel? {
        didSet{
            //可以给cell里相应的子控件绑定数据
           originalView.statusViewModel = statusViewModel
            statusToolBar.statusViewModel = statusViewModel
            //判断是否有转发内容
            if statusViewModel?.status?.retweeted_status != nil{
                //有转发微博，更新yuesu，显示转发微博，绑定数据
                reteennView.isHidden = false
                statusToolBar.snp_updateConstraints(closure: { (make) in
                    toolBarTopConstraint = make.top.equalTo(reteennView.snp_bottom).constraint
                })
                reteennView.statusViewModel = statusViewModel
            }else{
                //没有转发微博，更新约束，隐藏转发微博
                reteennView.isHidden = true
                statusToolBar.snp_updateConstraints(closure: { (make) in
                    toolBarTopConstraint = make.top.equalTo(originalView.snp_bottom).constraint
                })
            }
            
            print(statusViewModel?.status?.pic_urls?.first?.thumbnail_pic)
            
            
        }
    }
    //懒加载originalView
   private lazy var originalView: HMOriginalView = {
        let view = HMOriginalView()
        return view
    }()
    //懒加载转发微博
    private lazy var reteennView:HMReteenView = {
        let view = HMReteenView()
        return view
    }()

    //懒加载toolbar
    private lazy var statusToolBar:HMStatusToolBarView = HMStatusToolBarView()
    
    //重写init方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupCellUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupCellUI() {
        //添加控件
        contentView.addSubview(originalView)
        contentView.addSubview(reteennView)
        contentView.addSubview(statusToolBar)
        
        //添加原创微博约束
        originalView.snp_makeConstraints(closure: { (make) in
            make.top.trailing.leading.equalTo(contentView)
        })
        //转发微博的约束
        reteennView.snp_makeConstraints { (make) in
            make.top.equalTo(originalView.snp_bottom)
            make.leading.trailing.equalTo(originalView)
        }
        
        
        
        
        //添加底部的约束
        statusToolBar.snp_makeConstraints { (make) in
            toolBarTopConstraint = make.top.equalTo(reteennView.snp_bottom).constraint
            make.leading.trailing.equalTo((reteennView))
            make.height.equalTo(35)
            //关键约束
            make.bottom.equalTo(contentView.snp_bottom)
        }
        
        
    }
    

}
