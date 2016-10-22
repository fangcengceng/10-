//
//  HMDIscoverView.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/19.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class HMDIscoverView: UIView {

  
    @IBOutlet weak var searchButton: UIButton!
    //拿到文本框右边的约束
    @IBOutlet weak var textfieldRightConstraint: NSLayoutConstraint!
    //拿到文本框
    @IBOutlet weak var textField: UITextField!
    //点击按钮的事件,键盘收回，文本框回到原位
    @IBAction func searchButton(_ sender: AnyObject) {
        textField.resignFirstResponder()
//        self.endEditing(true)
        textfieldRightConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    //开始编辑的时候的动画
    @IBAction func begineditAction(_ sender: AnyObject) {
//
        textfieldRightConstraint.constant = searchButton.width
        UIView.animate(withDuration: 0.3) {
            //重新布局子控件
            self.layoutIfNeeded()
        }
        
    }
    //类方法,加载Xib
    class func searchView() ->HMDIscoverView{
        
        return UINib(nibName: "HMDIscoverView", bundle: nil).instantiate(withOwner: self, options: nil).last! as! HMDIscoverView
    }
    
    //设置textfield的自定义属性
    override func awakeFromNib() {
       textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 3
        textField.layer.cornerRadius = 5
        
    }

}



