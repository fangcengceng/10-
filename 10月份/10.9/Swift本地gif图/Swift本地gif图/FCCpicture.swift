//
//  FCCpicture.swift
//  Swift本地gif图
//
//  Created by codygao on 16/10/9.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class FCCpicture: NSObject {

    var icon: String?
    var desc: String?
    var count: NSNumber = 0
    
    init(dic: [String: Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
