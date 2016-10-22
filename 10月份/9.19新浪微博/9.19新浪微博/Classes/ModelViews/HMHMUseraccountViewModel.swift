//
//  HMHMUseraccountViewModel.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/26.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class HMHMUseraccountViewModel: NSObject {

    //创建一个全局的单例访问点
   static let shareduserAccountViewModel: HMHMUseraccountViewModel = HMHMUseraccountViewModel()
    
    //用户归档用户对象
    var userAccount: HMUserAccountModel? {
        return HMUserAccountModel.loadUserAccount()
    }
    
    var isLogin:Bool {
        return accessToken != nil
    }
    //判断accessToken是否过期
    var accessToken: String? {
        //用户token
        let token = userAccount?.access_token
        //过期时间
        let expiereDate = userAccount?.expiresDate
        //根据token存在 判断是否过期
        //判断是否登陆操作
        var isLogin: Bool? {
            return accessToken != nil
        }
        
        if let t = token {
            if expiereDate?.compare(Date()) == .orderedDescending{
                //如果过期时间大于我们当前时间结果是降序方式
                return t
            }else{
                
            return nil
        }
        
        }else{
            return nil
        }
    
    }
    
    
    //通过code获取accessToken
    
    func requeseAccessToken(code: String,callback: @escaping(Bool)->()) {
        HMNetworkTools.sharedTools.requestaccessToken(code: code) { (response, error) in
            if error != nil{
                print("网络请求异常")
                callback(false)
                print(error)
                return
            }
            
            //代码执行到此，网络请求成功
            guard let dic = response as? [String: Any] else{
                print("你不是一个正确的字典格式")
                callback(false)
                return
            }
            
            //代码执行到此，表示字典格式没有问题
            let useraccount = HMUserAccountModel(dic: dic)
            self.requestUserInfo(useraccount: useraccount,callBack: callback)
            
        }
    }
    
    func requestUserInfo(useraccount: HMUserAccountModel,callBack:@escaping (Bool)->()){
        HMNetworkTools.sharedTools.requestUserInfo(accessToken: useraccount.access_token!, uid: useraccount.uid) { (response, error) in
            if error != nil {
                print(error)
                callBack(false)
                print("网络请求出错")
            }
            
            guard let dic = response as? [String: Any] else{
                print("你不是一个正确的字典格式")
                callBack(false)
                return
            }
            //代码执行到此,表示用户登录成功
            print(dic)
            
            let name = dic["name"]
            let avart_large = dic["avatar_large"]
            
            useraccount.name = name as? String
            useraccount.avatar_large = avart_large as? String
            
            //代码执行到此，表示用户登录成功
            useraccount.saveUser()
            callBack(true)
        }
    }
    
    
}
