//
//  HMEmotionToolView.swift
//  Weibo20
//
//  Created by codygao on 16/10/6.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

//底部按钮的逻辑处理
enum FCCEmotionToolBarButtonType: Int {
    case recent = 1000
    case normal = 1001
    case emoji = 1002
    case lxh = 1003
}


class HMEmotionToolView: UIStackView {
    
    //记录按钮
    var lastButton: UIButton?
    //点击按钮执行闭包
    var callback: ((FCCEmotionToolBarButtonType)->())?

   
   override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        //设置滚动方向
        axis = .horizontal
        //设置布局方式
        distribution = .fillEqually
        
        
        //添加控件
        addChildButton(title: "最近", imageName: "compose_emotion_table_left",type: .recent)
        addChildButton(title: "最近", imageName: "compose_emotion_table_mid",type: .normal)
        addChildButton(title: "Emoji", imageName: "compose_emotion_table_mid",type: .emoji)
        addChildButton(title: "浪小花", imageName: "compose_emotion_table_right",type:.lxh)
        
    }
    
    
    func addChildButton(title: String, imageName: String,type: FCCEmotionToolBarButtonType) {
       
        let button = UIButton()
        button.tag = type.rawValue
        
        button.addTarget(self, action: #selector(buttonAction(btn:)), for: .touchUpInside)
        button.setTitle(title, for: .normal)
        //设置背景色
       
        button.setBackgroundImage(UIImage(named:imageName + "_normal" ), for: .normal)
        button.setBackgroundImage(UIImage(named:imageName+"_selected"), for: .selected)
        
        //设置字体颜色
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.darkGray, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        //去掉高亮状态
        button.adjustsImageWhenHighlighted = false
        
        addArrangedSubview(button)

    }
    
    //按钮的点击事件
    func buttonAction(btn: UIButton)  {
        lastButton?.isSelected = false
        btn.isSelected = true
        lastButton = btn
//        btn.isSelected = !btn.isSelected
        
        //点击按钮的时候通知上一个视图去做事情，定义闭包
        let type = FCCEmotionToolBarButtonType(rawValue: btn.tag)!
        callback?(type)
        
    }
    

}
