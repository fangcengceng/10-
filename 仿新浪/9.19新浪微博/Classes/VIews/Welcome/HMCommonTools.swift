//
//  HMCommonTools.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/26.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

//切换根视图控制器的通知名
let switchRootVCNotification = "switchRootVCNotification"

//设置随机颜色
func randomcolor() -> UIColor {
    let red = arc4random() % 256
    let green = arc4random() % 256
    let blue = arc4random() % 256
    let color: UIColor = UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    
    return color
}

//屏幕宽高
let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height


