//
//  HMStatsViewModel.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/26.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit
//封装首页自定义cell 的业务逻辑处理
class HMStatsViewModel: NSObject {
    //微博模型对象
    var status: HMStatus?
    //提供会员等级图片
    var mbrankImage: UIImage?
    //转发数
    var retweentCountContent: String?
    //转发微博内容
    var retweentContent: String?
    //评论数
    var commentCountContent: String?
    //赞
    var unlikeCountContent: String?
    
    init(status: HMStatus){
        super.init()
        self.status = status
        //处理业务逻辑
        handelBrandImage(mbrank: status.user?.mbrank ?? 0)
        retweentCountContent = handleCountContent(count: status.reposts_count, defaultTitle: "转发")
        commentCountContent = handleCountContent(count: status.comments_count, defaultTitle: "评论")
        unlikeCountContent = handleCountContent(count: status.attitudes_count, defaultTitle: "赞")
        handleRetweenContent(statis: status)
        
    }
    //处理转发微博内容显示
    private func handleRetweenContent(statis: HMStatus) {
        if statis.retweeted_status != nil{
            let name = statis.retweeted_status?.user?.screen_name
            let text = statis.retweeted_status?.text
            if name != nil && text != nil{
                retweentContent = "@\(name):\(text)"
            }
        }
    }
    
    //处理转发，评论，暂数据显示
    private func handleCountContent(count: Int,defaultTitle: String) -> String{
        if  count > 0 {
            return "\(count)"
        }else{
            return defaultTitle
        }
        
    }
    
    
    func handelBrandImage(mbrank: Int){
        //判断数据是否在1-6之间
        if mbrank >= 1 && mbrank <= 6{
            mbrankImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        if mbrank == 0 {
            mbrankImage = UIImage(named: "common_icon_membership_expired")
        }
        
        
    }
    

}
