//
//  HMLabel.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/26.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(fontsize: CGFloat,textclor: UIColor) {
        self.init()
        self.font = UIFont.systemFont(ofSize: fontsize)
        self.textColor = textclor
    }
    
}
