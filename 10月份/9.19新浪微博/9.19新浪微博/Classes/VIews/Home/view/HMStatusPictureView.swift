//
//  HMStatusPictureView.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/27.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit
private let HmstatusPictureCellIdentifer = "HmstatusPictureCellIdentifer"
//没想之间的距离
let itemMargin: CGFloat = 5
//每项的宽度
let itemWidth = (screenWidth - 2 * childViewMargin - 2 * itemMargin) / 3
class HMStatusPictureView: UICollectionView {

    //设置配图数据源
    var picUrls: [HMStatusPictureInfo]?{
        didSet{
          
          
                contentLabel.text = "\(picUrls?.count ?? 0)"
                let size = caldSize(count: picUrls?.count ?? 0)
                self.snp_updateConstraints(closure: { (make) in
                    make.size.equalTo(size)
                })
            self.reloadData()
            
        }
    }
    //懒加载数字标签
    private lazy var contentLabel: UILabel = {
        let label = UILabel(fontsize: 15, textclor: UIColor.red)
        return label
    }()
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowlayout.minimumLineSpacing = itemWidth
        flowlayout.minimumInteritemSpacing = itemWidth
        super.init(frame: frame, collectionViewLayout: flowlayout)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //界面搭建
    private func setupUI() {
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: HmstatusPictureCellIdentifer)
        self.dataSource = self
        
     
        addSubview(contentLabel)
        
        contentLabel.snp_makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
    }
    //根据图片战术计算配图大小
    private func caldSize(count: Int) ->CGSize{
       
        let cols = count > 3 ? 3: count
        let rows = (count - 1) / 3 + 1
        let currentWidth = itemWidth * CGFloat(cols) + CGFloat(cols - 1) * itemMargin
        //  计算当前配图的高度
        let currentHeight = itemWidth * CGFloat(rows) + CGFloat(rows - 1) * itemMargin
        return CGSize(width: currentWidth, height: currentHeight)
    }
    
}


extension HMStatusPictureView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HmstatusPictureCellIdentifer, for: indexPath)
        cell.backgroundColor = randomcolor()
        return cell
    }
    
}
