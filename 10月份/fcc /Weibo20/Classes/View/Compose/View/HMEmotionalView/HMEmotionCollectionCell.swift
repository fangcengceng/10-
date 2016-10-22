//
//  HMEmotionCollectionCell.swift
//  Weibo20
//
//  Created by codygao on 16/10/7.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class HMEmotionCollectionCell: UICollectionViewCell {
    
    //记录表情按钮
   private var emotionbuttonArrry: [UIButton] = [UIButton]()
    
  
    
    
    //接受为界传来的数据，给子控件设置数据
    var indexPath: IndexPath? {
        didSet{
            messageLabel.text = "当前显示的是第\(indexPath!.section) 行第\(indexPath!.row) 列"
            
        }
    }
    
    fileprivate lazy var messageLabel: UILabel = UILabel(textColor: .black, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //界面搭建
    func setupUI()  {
        //添加子控件
         addchildButton()//调用抽取的方法
        contentView.addSubview(messageLabel)

        messageLabel.snp_makeConstraints { (make) in
            make.center.equalTo(contentView)
        }
       backgroundColor = RandomColor()
     

    }
    
    //添加20个表情按钮主方法
    func addchildButton()  {
 
   
        //创建21个表情按钮
        for _ in 0..<20 {
            let button = UIButton()
            
            button.backgroundColor = RandomColor()
           
            contentView.addSubview(button)
            emotionbuttonArrry.append(button)
            
        }
 
        
    }
    
    
    //布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        //按钮的宽高
        let buttonWidth = width / 7
        let buttonHeight = height / 3
        for (i,button) in emotionbuttonArrry.enumerated() {
           
          button.size = CGSize(width: buttonWidth, height: buttonHeight)
            //行数
            //行数
            let rows = i / 7
            let colums = i % 7
            button.y = CGFloat(rows) * buttonHeight
            button.x = CGFloat(colums) * buttonWidth
 
        }
        
    }
    
    
    
    
    
  //END
}
