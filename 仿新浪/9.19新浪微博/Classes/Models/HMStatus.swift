//
//  HMStatus.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/26.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class HMStatus: NSObject {

//    created_at	string	微博创建时间
    var created_at: String?
    
    //    text	string	微博信息内容
    var text: String?
    
    //    id	int64	微博ID
    var id: Int64 = 0
    
    //    	微博来源
    var source: String?
    //用户模型
    var user: HMUser?
    //  转发数
    var reposts_count: Int = 0
    //  评论数
    var comments_count: Int = 0
    //  赞
    var attitudes_count: Int = 0
    //  转发微博
    var retweeted_status: HMStatus?
    //微博配图模型数组
    var pic_urls: [HMStatusPictureInfo]?
    //  swift 写法, 指定集合属性元素类型
    class func modelContainerPropertyGenericClass() -> [String: Any] {
        
        return [
            "pic_urls": HMStatusPictureInfo.self
        ]
        
    }


    
//    //KVC 构造函数
//    init(dic: [String: Any]) {
//        super.init()
//        setValuesForKeys(dic)
//    }
//    override func setValue(_ value: Any?, forKey key: String) {
//
//        if key == "user"{
//            guard let dic = value as? [String: Any] else {
//                
//                print("字典格式有错")
//                return
//            }
//            
//            user = HMUser(dic: dic)
//            
//        }else{
//            super.setValue(value, forKey: key)
//        }
//        
//        
//        
//        
//        
//    }
//    
//    //防止字段不匹配造成崩溃
//    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//        
//    }
    
    
 //END
}
