//
//  HMStausViewModel.swift
//  Weibo20
//
//  Created by HM on 16/9/23.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit
//  封装微博首页自定义cell业务逻辑处理 -> 自定义cell(微博首页cell)
class HMStatusViewModel: NSObject {

    //  原创微博富文本
    var originalAttributedString: NSAttributedString?
    //  转发微博富文本
    var retweetAtrributedString: NSAttributedString?
    
    //  微博模型对象
    var status: HMStatus?
    
    
    //  提供会员等级图片
    var mbrankImage: UIImage?
    
    //  转发数
    var retweetCountContent: String?
    //  评论数
    var commentCountContent: String?
    //  赞
    var unlikeCountContent: String?
    //  转发微博内容
    var retweetContent: String?
    //  认证类型的图片
    var verifiedTypeImage: UIImage?
    //  来源
    var sourceContent: String?

    
    /*  时间格式化逻辑
        是否是今年
            是否是今天
                是否是1分钟之前
                    刚刚
                是否是1小时之前
                    xx分钟前
                其它
                    xx小时前
     
     
            是否是昨天
                昨天 10:21
     
            其它
                11-21 11:11
     
        不是今年
            2015-10-21 10:10
     
     
     */
    
    var timeContent: String? {
        
        guard let createAt = status?.created_at  else {
            return nil
        }
        
        return Date.sinaDate(createAt: createAt).sinaDateString
        
//        let createDate = Date.sinaDate(createAt: createAt)
//        return createDate.sinaDateString
        
//        //  代码到此表示时间字符串不为nil
//        let dt = DateFormatter()
//        //  指定格式化方式
//        dt.dateFormat = "EEE MMM dd HH:mm:ss z yyyy"
//        //  指定本地化信息
//        dt.locale = Locale(identifier: "en_US")
//        //  把字符串转成时间对象
//        let createAtDate = dt.date(from: createAt)!
//        print(createAtDate)
        
        
//        if isThisYear(createAtDate: createAtDate) {
//        
//            //是今年
//            print("是今年")
//            //  日历对象
//            let currentCalendar = Calendar.current
//            if currentCalendar.isDateInToday(createAtDate) {
//                //  表示今天createAtDate.timeIntervalSince(<#T##date: Date##Date#>)
//                let timeinterVal: TimeInterval = abs(createAtDate.timeIntervalSinceNow)
//                if timeinterVal < 60 {
//                    return "刚刚"
//                } else if timeinterVal < 3600 {
//                    let result = timeinterVal / 60
//                    return "\(Int(result))分钟前"
//                } else {
//                    let result = timeinterVal / 3600
//                    return "\(Int(result))小时前"
//                }
//                
//                
//                
//                
//            } else if currentCalendar.isDateInYesterday(createAtDate) {
//                //  表示昨天
//                dt.dateFormat = "昨天 HH:mm"
//            } else {
//                //  其它
//                dt.dateFormat = "MM-dd HH:mm"
//            }            
//            
//            
//        } else {
//            //  不是今年
//            dt.dateFormat = "yyyy-MM-dd HH:mm"
//            
//        }
//        
//        
//        
//        
//        return dt.string(from: createAtDate)
    }
    
    init(status: HMStatus) {
        super.init()
        self.status = status
        
        //  处理业务逻辑
        handleMBrankImage(mbrank: status.user?.mbrank ?? 0)
        
        retweetCountContent = handleCountContent(count: status.reposts_count, defaultTitle: "转发")
        commentCountContent = handleCountContent(count: status.comments_count, defaultTitle: "评论")
        unlikeCountContent = handleCountContent(count: status.attitudes_count, defaultTitle: "赞")
        
        
        handleRetweetContent(status: status)
        
        handleVerifiedTypeImage(verifiedType: status.user?.verified_type ?? 0)
        handleSourceContent(source: status.source ?? "")
       originalAttributedString = handleStatusAttributedString(status: status.text!)
        
        
        
        
    }
    
    
    private func handleStatusAttributedString(status: String) -> NSAttributedString {
        //  先把微博字符串转成富文本
        let resultAttributedString = NSMutableAttributedString(string: status)
        //  根据正则匹配字符串
        let matchResult = try! NSRegularExpression(pattern: "\\[\\w+\\]", options: []).matches(in: status, options: [], range: NSMakeRange(0, (status as NSString).length))
        
        for match in matchResult.reversed() {
            let range = match.range
            let chs = (status as NSString).substring(with: range)
            //  通过表情描述查找表情模型
            if let emoticon = HMEmotionalTool.sharedEmotion.selectedEmoticon(chs: chs) {
                //  有对应的表情模型
                print(emoticon.png!)
                //  根据表情模型里面的图片路径创建对应的富文本
                let attrbutedStr = NSAttributedString.attributedStringWithEmoticon(emoticon: emoticon, font: UIFont.systemFont(ofSize: 14))
                print(status)
                //  根据指定范围替换成表情富文本
                resultAttributedString.replaceCharacters(in: range, with: attrbutedStr)
                
            }
        }
        
        
        
        //  设置全部富文本的字体大小
        resultAttributedString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14), range: NSMakeRange(0, resultAttributedString.length))
        
        return resultAttributedString
        
        
    }
    
    
    
    
    
    
    
    

    
    //  处理来源数据
    private func handleSourceContent(source: String) {
        //<a href="http://app.weibo.com/t/feed/6vtZb0" rel="nofollow">微博 weibo.com</a>
    
        //  判断其字符串是否有包含特定的字符串
        if source.contains("\">") && source.contains("</") {
            
            //  代码执行到此,获取特定字符串的范围-> range
            
            let startRange = source.range(of: "\">")!
            let endRange = source.range(of: "</")!
            
            //  光标的上限索引
            let startIndex = startRange.upperBound
            //  光标的下限索引
            let endIndex = endRange.lowerBound
            
            //  获取子串
            sourceContent = "来自: " + source.substring(with: startIndex..<endIndex)
            
            
            
        
        }
        
        
        
        
        
        
    }
    
    
    //  处理认证类型等级图片逻辑
    private func handleVerifiedTypeImage(verifiedType: Int) {
        //  认证类型等级 -1：没有认证，1，认证用户，2,3,5: 企业认证，220: 达人
        switch verifiedType {
        case 1:
            verifiedTypeImage = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            verifiedTypeImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedTypeImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedTypeImage = nil
        }
        
        
        
    }
    
    //  处理转发微博内容显示
    private func handleRetweetContent(status: HMStatus) {
        
        if status.retweeted_status != nil {
            //  获取转发微博的用户名
            let name = status.retweeted_status?.user?.screen_name
            
            //  获取转发微博的内容
            let text = status.retweeted_status?.text
            
            if name != nil && text != nil {
                //  转发微博内容拼接
                retweetContent = "@\(name!): \(text!)"
                
                
            }
            
        }
        
    
    }
    
    
    //  处理转发,评论,赞数据显示
    private func handleCountContent(count: Int, defaultTitle: String) -> String {
        
        if count > 0 {
            return "\(count)"
        } else {
            return defaultTitle
        }
        
    
    }
    
    
    //  处理会员等级逻辑
    private func handleMBrankImage(mbrank: Int) {
    
        //  判断数据是否在1-6之间
        
        if mbrank >= 1 && mbrank <= 6 {
            
            mbrankImage = UIImage(named: "common_icon_membership_level\(mbrank)")
            
        }
    
    }
    
    
    
    
    
    
    
    
}
