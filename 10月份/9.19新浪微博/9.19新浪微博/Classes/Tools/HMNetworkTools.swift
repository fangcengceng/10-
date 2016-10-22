//
//  HMNetworkTools.swift
//  Swift网络请求封装
//
//  Created by HM on 16/9/20.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit
import AFNetworking

//  网络请求类型
enum RequestType: Int {
    // get请求
    case GET
    // post请求
    case POST
}

//  网络请求封装类
class HMNetworkTools: AFHTTPSessionManager {

    //  单例全局访问点
    static let sharedTools: HMNetworkTools = {
        let tools = HMNetworkTools()
        //  添加可以接受的响应数据类型
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    
    }()
    
    //  封装get/post请求
  fileprivate  func request(type: RequestType, url: String, params: Any?, callBack: @escaping (Any?, Error?)->()) {
        
        if type == .GET {
            get(url, parameters: params, progress: nil, success: { (_, response) in
                callBack(response, nil)
                }, failure: { (_, error) in
                    callBack(nil, error)
            })
            
        } else {
            post(url, parameters: params, progress: nil, success: { (_, response) in
                callBack(response, nil)
                }, failure: { (_, error) in
                callBack(nil, error)
            })
            
        }
        
    }
    
    
    
//END
}

//OAuth登陆相关接口
extension HMNetworkTools{
    //MARK: 根据code获取accessToken
    func requestaccessToken(code: String, callBack:@escaping (Any?,Error?)->()) {
       //请求接口地址
        let url = "https://api.weibo.com/oauth2/access_token"
        
       let params = [
            "client_id": WeiboAppkey,
            "client_secret": WeiboAppSecret,
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": WeiboRedirect_uri
            
        ]
        
        request(type: .POST, url: url, params: params, callBack: callBack)
        
    }
    
    
    
    //根据accessTocken 获取用户信息接口
    func requestUserInfo(accessToken: String,uid: Int64,callBack:@escaping (Any?,Error?)->()) {
        let url = "https://api.weibo.com/2/users/show.json"
        let params: [String: Any] = ["access_token":accessToken,"uid":uid]
        request(type: .GET, url: url, params: params, callBack: callBack)

    }
    
    //微博首页数据相关接口
    func requestHomeStatusInfo(accessTocken: String,callback:@escaping (Any?,Error?)->()) {
        
       let url = "https://api.weibo.com/2/statuses/friends_timeline.json"
        
        let params = ["access_token":accessTocken]
        request(type: .GET, url: url, params:params , callBack: callback)
  
    }
      
}


