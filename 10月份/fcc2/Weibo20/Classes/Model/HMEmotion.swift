//
//  HMEmotion.swift
//  Weibo20
//
//  Created by codygao on 16/10/7.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class HMEmotion: NSObject,NSCoding {
    //表情描述
    var chs: String?
    //图片名称
    var png:  String?
    //表情类型 0-图片，1-emoj
    var type: String?
    //emoji字符串，16进制字符串
    var code: String?
    
    //图片对应的路径
    var path: String?
    
    //图片对应的文件夹名字
    var folderName: String?
    
    
    //使用yy_model需要归档，需要重写此方法
    override init() {
        super.init()
    }
    
    //解档方法
    required init?(coder aDecoder: NSCoder) {
        chs = aDecoder.decodeObject(forKey: "chs") as? String
        png = aDecoder.decodeObject(forKey: "png") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String
        code = aDecoder.decodeObject(forKey: "code") as? String
        path = aDecoder.decodeObject(forKey: "path") as? String
        folderName = aDecoder.decodeObject(forKey: "folderName") as? String
        
        //图片路径会变化
        if type == "0"{
            //如果是图片，需要重写拼接图片全路径
            let imagePath = HMEmotionalTool.sharedEmotion.emotionBundle.path(forResource: folderName, ofType: nil)! + "/" + png!
            path = imagePath
        }
        
        
        
    }
        
        
    
    //归档方法
    func encode(with aCoder: NSCoder) {
        aCoder.encode(chs, forKey: "chs")
        aCoder.encode(png, forKey: "png")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(code, forKey: "code")
        aCoder.encode(path, forKey: "path")
        aCoder.encode(folderName, forKey: "folderName")
    }
    
    
    

}
