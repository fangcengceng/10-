//
//  HMEmotionButton.swift
//  Weibo20
//
//  Created by codygao on 16/10/7.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class HMEmotionButton: UIButton {

    //自定义表情按钮
    var emtion: HMEmotion? {
        didSet{
            guard let etn = emtion else {
                return
            }
           
            self.isHidden = false
            
            if etn.type == "0" {
                
                self.setImage(UIImage(named:etn.path!), for: .normal)
                self.setTitle(nil, for: .normal)

            }else{
                self.setTitle((etn.code! as NSString).emoji(), for: .normal)
                self.setImage(nil, for: .normal)

            
            }
            
            
        }
    }
    
    
    
    
    
}
