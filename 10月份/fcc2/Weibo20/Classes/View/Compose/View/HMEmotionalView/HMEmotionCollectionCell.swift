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
   private var emotionbuttonArrry: [HMEmotionButton] = [HMEmotionButton]()
    
    //准备数据源模型,接收外界传来的数据
    var emotionsArray: [HMEmotion]? {
        didSet{
            guard let array = emotionsArray else {
                print("数组为空")
                return
                
            }
            
            //遍历表情按钮,先将按钮隐藏
            for button in emotionbuttonArrry{
                //隐藏
                button.isHidden = true
            }
            
            //遍历表情数组模型，给表情按钮绑定数据
            for (i,emotion) in array.enumerated(){
                
                //获取表情按钮
                let button = emotionbuttonArrry[i]
                button.emtion = emotion
//                设置表情按钮可见
                
               // button.isHidden = false
                
//                //emotion是模型
//                if emotion.type == "0" {
//                    //  表示图片,直接设置button的image,
//                    //  问题-> 图片的路径需要拼接完整
//                    button.setImage(UIImage(named: emotion.path!), for: .normal)
//                    
//                    button.setTitle(nil, for: .normal)
//                }else{
//                    //表示emoji图片
//                    let title = ((emotion.code)! as NSString).emoji()
//                    button.setTitle(title, for: .normal)
//                    
//                    button.setImage(nil, for: .normal)
//                }

            }
        }
        
        
    }
  
    
    
    //接受为界传来的数据，给子控件设置数据
    var indexPath: IndexPath? {
        didSet{
            messageLabel.text = "当前显示的是第\(indexPath!.section) 行第\(indexPath!.row) 列"
            
        }
    }
    
    //懒加载删除按钮
    
    fileprivate lazy var deletButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(deletButtonAction), for: .touchUpInside)
        button.setImage(UIImage(named:"compose_emotion_delete"), for: .normal)
        button.setImage(UIImage(named:"compose_emotion_delete_highlighted"), for: .highlighted)
        button.sizeToFit()
        return button
    }()
    

    
    
    //懒加载控件messageLabel
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
        contentView.addSubview(deletButton)
        
        

        messageLabel.snp_makeConstraints { (make) in
            make.center.equalTo(contentView)
        }
        
        
        
     

    }
    
    //添加20个表情按钮主方法
    func addchildButton()  {
 
   
        //创建21个表情按钮
        for _ in 0..<20 {
            let button = HMEmotionButton()
            //按钮添加点击事件
            button.addTarget(self, action: #selector(showpopViewAction(btn:)), for: .touchUpInside)
            
            

            
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
            
            
            //设置删除按钮的位置
            deletButton.size = CGSize(width: buttonWidth, height: buttonHeight)
            deletButton.x = width - buttonWidth
            deletButton.y = height - buttonHeight
            
        }
        
    }
    
    //监听删除按钮的通知
    @objc private func deletButtonAction() {
        //注册通知，让控制器删除textView内容
        NotificationCenter.default.post(name: NSNotification.Name(didSelectedDeletButtonNotification), object: nil)
        
        
    }
    
    
    //监听表情点击按钮,添加popview
    @objc private func showpopViewAction(btn: HMEmotionButton) {
        
        
        let emotion = btn.emtion
        //注册通知，将选中的按钮图片添加到textView中
        NotificationCenter.default.post(name: NSNotification.Name(didSelectedEmotionNotification), object: emotion)
        
        
        
        
        //懒加载控件
        let popView: HMEmotionalPopView = HMEmotionalPopView.sharedPopview()
        //取得windowe
        let window = UIApplication.shared.windows.last
        window?.addSubview(popView)
//        popView.center = btn.center,需要转换坐标
        let convertFrame = contentView.convert(btn.frame, to: window)
        
//        print(convertFrame)
        
       popView.popButton.emtion = emotion
        
        
        popView.y = convertFrame.maxY - popView.height
        popView.centerX = convertFrame.midX
        
        //延时0.25秒移除popview
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) {
            popView.removeFromSuperview()
        }
        

        
        
        

    }
    
    
    
    
  //END
}
