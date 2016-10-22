//
//  HMTextField.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/20.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

//实时看到XIB 的结果
@IBDesignable
class HMTextField: UITextField {

    //设置边框宽度，需要用到layer
  @IBInspectable  var bordWidth: CGFloat?{
        //属性观察器
        didSet{
           self.layer.borderWidth = bordWidth ?? 0
        }
    }
    
    //设置边框的颜色
  @IBInspectable  var borderColor: UIColor?{
        didSet{
            self.layer.borderColor = borderColor as! CGColor?
            
        }
    }
    
    //设置边框的圆角
  @IBInspectable  var cornerCorner: CGFloat?{
        didSet{
            self.layer.cornerRadius = cornerCorner ?? 0
            self.layer.masksToBounds = true
        }
    }
    
    
    

}
