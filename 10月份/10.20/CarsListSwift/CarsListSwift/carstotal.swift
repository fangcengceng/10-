//
//  carstotal.swift
//  CarsListSwift
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class carstotal: NSObject {

    var title: String?
    var cars: carsDetail?
    
//    + (NSDictionary *)modelContainerPropertyGenericClass {
//    // value should be Class or Class name.
//    return @{@"shadows" : [Shadow class],
//    @"borders" : Border.class,
//    @"attachments" : @"Attachment" };
//    }
    
//    func modelContainerPropertyGenericClass() -> [String: Any] {
//        
//        return ["cars": carsDetail.self]
//    }
    
    init(dic: [String: Any]) {
        super.init()
        self.setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "cars" {
            
            guard let dic = value as? [String: Any] else {
                print("字典格式不争取")
                return
            }
            
            super.setValue(dic, forKey: key)
        
        
          }
    
        
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}
