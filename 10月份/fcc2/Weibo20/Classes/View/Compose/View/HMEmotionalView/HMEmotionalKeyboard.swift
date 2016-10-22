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
    //懒加载pageControl
    fileprivate lazy var pageCtr: UIPageControl = {
        let ctr = UIPageControl()
        ctr.currentPageIndicatorTintColor = UIColor(patternImage: UIImage(named:"compose_keyboard_dot_selected")!)
        ctr.pageIndicatorTintColor = UIColor(patternImage: UIImage(named:"compose_keyboard_dot_normal")!)
        ctr.hidesForSinglePage = true
        
        ctr.numberOfPages = 5
        return ctr
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
        view.isPagingEnabled = true
        view.backgroundColor = self.backgroundColor
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
    backgroundColor = UIColor(patternImage: UIImage(named: "emoticon_keyboard_background")!)

    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //界面搭建
    func setupUI() {
        
        //设置一开始就滚动到的indexpath,不然的话一开始定位在最近这一组，需要点击是才会滚动到对应的collectionview
        let normalIndexPaht = IndexPath(item: 0, section: 1)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: normalIndexPaht, at: .left, animated: false)
        }
       
        //调用pagectr的方法
      self.loadpageNums(indexpath: normalIndexPaht)
        
      
        
        
        
        //添加底部的控件
        addSubview(toolBarView)
        addSubview(collectionView)
        addSubview(pageCtr)
        
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
        //pagecontrol的约束
        pageCtr.snp_makeConstraints { (make) in
            make.centerX.equalTo(collectionView)
            make.bottom.equalTo(collectionView)
            make.height.equalTo(30)
        }
        
        
        //执行闭包
        toolBarView.callback = {[weak self] (type: FCCEmotionToolBarButtonType) in
            
            let indexpath: IndexPath
            
            
            switch type {
            case .recent:
                print("最近")
                indexpath = IndexPath(item: 0, section: 0)
            case .normal:
                print("默认")
                indexpath = IndexPath(item: 0, section: 1)
            case .emoji:
                print("emoji")
                indexpath = IndexPath(item: 0, section: 2)
            case .lxh:
                print("浪小花")
                indexpath = IndexPath(item: 0, section: 3)
            }
            
            //让collectionView滚动到指定的indexpath,不需要开启动画
            self?.collectionView.scrollToItem(at: indexpath, at: .left, animated: false)
            self?.loadpageNums(indexpath: indexpath)
            
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
    
    //通过indexpath绑定pagectr的页码
    func loadpageNums(indexpath: IndexPath) {
        
        pageCtr.numberOfPages = HMEmotionalTool.sharedEmotion.allEmotionArray.count
        //行数
        pageCtr.currentPage = indexpath.item
        
        
    }
    
    //提供刷新最近表情数据接口
    func  reloadRecentData() {
        
        let indexpath = IndexPath(item: 0, section: 0)
        collectionView.reloadItems(at: [indexpath])
        
        
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
        cell.emotionsArray = HMEmotionalTool.sharedEmotion.allEmotionArray[indexPath.section][indexPath.item]
 
        cell.indexPath = indexPath
        
        return cell
    }
    
    //监听滚动，设置选中的toolbar按钮
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffX = scrollView.contentOffset.x + width * 0.5
        let contentOffY = scrollView.contentOffset.y + height * 0.5

        //获取偏移中心点
        let centerPoint = CGPoint(x: contentOffX, y: contentOffY)
        
        //根据collectionview的方法获取index
        if let indexpath = collectionView.indexPathForItem(at: centerPoint){
        
          print(indexpath.section)
          toolBarView.selectedButton(section: (indexpath.section))
          self.loadpageNums(indexpath: indexpath)
        }
    }
    
    
    
}
