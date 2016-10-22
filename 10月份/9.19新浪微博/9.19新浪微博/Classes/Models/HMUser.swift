//
//  HMUser.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/26.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class HMUser: NSObject {

    //用户id
    var id: Int64 = 0
    //用户昵称
    var screen_name: String?
    
    //用户头像地址
    var profile_image_url: String?
    
    //  认证类型等级 -1：没有认证，1，认证用户，2,3,5: 企业认证，220: 达人
    var verified_type: Int = 0
    
    //  会员等级 1 - 6
    var mbrank: Int = 0
//    //KVC构造函数
//    init(dic: [String: Any]) {
//        super.init()
//        setValuesForKeys(dic)
//        
//    }
//    //防止字段不匹配
//    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//        
//    }
    
}
