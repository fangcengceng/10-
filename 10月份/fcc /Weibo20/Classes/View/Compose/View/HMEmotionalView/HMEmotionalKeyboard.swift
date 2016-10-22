//
//  HMEmotionalKeyboard.swift
//  Weibo20
//
//  Created by codygao on 16/10/6.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit
//自定义一键盘视图
/*
 collectionView
 toolBar
 pageControl
 
 
 */

//cell重用标记
private let emotionCollectionCellResue = "emotionCollectionCellResue"
class HMEmotionalKeyboard: UIView {
    //懒加载底部子控件
    fileprivate lazy var toolBarView: HMEmotionToolView = {
       let view = HMEmotionToolView()
        view.backgroundColor = UIColor.blue
        return view
        
    }()
    //懒加载collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
       let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //view相关布局
        view.backgroundColor = .white
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.bounces = false
        //layOut 相关布局
        layout.scrollDirection = .horizontal
        
        //数据源
        view.dataSource = self
        view.delegate = self
        view.register(HMEmotionCollectionCell.self, forCellWithReuseIdentifier: emotionCollectionCellResue)

        return view
        
    }()
    
    
    

   override init(frame:CGRect) {
        super.init(frame:frame)
         setupUI()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //界面搭建
    func setupUI() {
        //添加底部的控件
        addSubview(toolBarView)
        addSubview(collectionView)
        
        //collectionView的相关约束
        collectionView.snp_makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.right.equalTo(self)
            make.bottom.equalTo(toolBarView.snp_top)
        }
        //底部toolbar约束
        toolBarView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(35)
        
        }
        
        //执行闭包
        toolBarView.callback = {[weak self] (type: FCCEmotionToolBarButtonType) in
            
            switch type {
            case .recent:
                print("最近")
            case .normal:
                print("默认")
            case .emoji:
                print("emoji")
            case .lxh:
                print("浪小花")
            }
            
        }

    }
    
    
    //设置表情视图item的大小
    override func layoutSubviews() {
        super.layoutSubviews()
        let flowlayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowlayout.itemSize = collectionView.size
        flowlayout.minimumLineSpacing = 0
        flowlayout.minimumInteritemSpacing = 0
        
    }
    
    
    
//End
}


extension HMEmotionalKeyboard: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HMEmotionalTool.sharedEmotion.allEmotionArray.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HMEmotionalTool.sharedEmotion.allEmotionArray[section].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emotionCollectionCellResue, for: indexPath) as! HMEmotionCollectionCell
        cell.indexPath = indexPath
        
        return cell
    }
    
    
    
}
