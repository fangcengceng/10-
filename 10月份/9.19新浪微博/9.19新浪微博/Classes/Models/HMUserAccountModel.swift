//
//  HMUserAccountModel.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/25.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

//存储路径
private let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("useraccount.achiver")

class HMUserAccountModel: NSObject,NSCoding {
   
    //用户授权唯一票据
    var access_token: String?
    //注册时间
    var expires_in: TimeInterval = 0 {
        didSet{
            expiresDate = Date().addingTimeInterval(expires_in)
        }
    }
    //过期时间对象
    var expiresDate: Date?
    
    
    
    //用户uid
    var uid: Int64 = 0
    //用户信息
    //用户姓名
    var name: String?
    //用户头像
    var avatar_large: String?
    
   //KVC构造方法
    init(dic: [String: Any]) {
        super.init()
       setValuesForKeys(dic)
        
    }
    //防止字段不匹配
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    //归档主方法
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        aCoder.encode(expiresDate, forKey: "expires_Date")
        
        
    }
    //结档主方法
    required init?(coder aDecoder: NSCoder) {
        uid = aDecoder.decodeInt64(forKey: "uid")
        name = aDecoder.decodeObject(forKey: "name") as! String?
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as! String?
        access_token = aDecoder.decodeObject(forKey: "access_token") as! String?
        expiresDate = aDecoder.decodeObject(forKey: "expires_Date") as! Date?
    }
    
    //存储userInfo
    func saveUser() -> () {
       
        NSKeyedArchiver.archiveRootObject(self, toFile: path)
        
    }
    
    //读取userInfo
    class func loadUserAccount() -> HMUserAccountModel?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: path) as? HMUserAccountModel
    }

    //END
}
