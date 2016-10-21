//
//  carsDetail.swift
//  CarsListSwift
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class carsDetail: NSObject {
    var name: String?
    var icon: String?

    
    init(dic: [String: Any]){
        super.init()
        self.setValuesForKeys(dic)
    }
    
}
