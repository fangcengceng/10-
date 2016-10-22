//
//  HMEmotionalPopView.swift
//  Weibo20
//
//  Created by codygao on 16/10/7.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class HMEmotionalPopView: UIView {

    
    @IBOutlet weak var popButton: HMEmotionButton!
    
  class func sharedPopview()-> HMEmotionalPopView {
        
        return UINib.init(nibName: "HMEmotionalPopView", bundle: nil).instantiate(withOwner: nil, options: nil).last! as! HMEmotionalPopView

        
    }
    
    
    
    

}
