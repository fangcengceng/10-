//
//  HMEmotionalTool.swift
//  Weibo20
//
//  Created by codygao on 16/10/7.
//  Copyright © 2016年 HM. All rights reserved.
//


//读取表情工具类
import UIKit

//每一页显示的二维数组个数
let numberOfitemInpage = 20

let recentPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("recent.archierver")


class HMEmotionalTool: NSObject {
    
    //创建全局单例接入点
    static let sharedEmotion: HMEmotionalTool = HMEmotionalTool()
    
   //构造函数私有化
   private override init() {
        super.init()
    
    }
    //加载三维数组
    lazy var allEmotionArray: [[[HMEmotion]]] = {
        return [
            [self.recentArray],
            self.sectionEmoticon(emoticonArray:self.defaultArray),
            self.sectionEmoticon(emoticonArray: self.emojitArray),
            self.sectionEmoticon(emoticonArray: self.lxhArray),
        ]
    }()
    
    
    
    
    //懒加载获取bundel对象
    lazy var emotionBundle: Bundle = {
        //获取emotionBundle的路径,借鉴加载plist文件
        let path = Bundle.main.path(forResource: "Emoticons.bundle", ofType: nil)!
        //这个是创建bundle 对象的系统方法，需要传入一个路径
        
        let bundle = Bundle(path: path)!
        return bundle
    }()
    
    //加载plist数据的主方法，因为三个plist都需要加载，所以抽取成方法
    private func loadEmotionArray(folderName: String, fileName: String) ->[HMEmotion] {
        //  self.emoticonsBundle.path(forResource: xxx)  可以透过两次文件夹 (Contents/Resources)
        //  获取info.plist文件路径
        let subPath = folderName + "/" + fileName
        //读取plist文件
        let path = self.emotionBundle.path(forResource: subPath, ofType: nil)!
        //读取资源数据
        let dicArray = NSArray(contentsOfFile: path) as! [[String: Any]]
        
        //使用yyModel把字典转成模型
        let modelArray = NSArray.yy_modelArray(with: HMEmotion.self, json: dicArray) as! [HMEmotion]
        
        //加载图片资源
        
        for model in modelArray {
            
            //判断是否是图片
            if model.type == "0" {
                let imagepath = self.emotionBundle.path(forResource: folderName, ofType: nil)! + "/" + model.png!
                //设置图片的全路径
                model.path = imagepath
                
                //设置图片对应的文件夹
                model.folderName = folderName

            }
            
            
        }
        
        
        
        
        return modelArray
        
        
    }
    
    
    //加载最近表情数据，空数组
    private lazy var recentArray: [HMEmotion] = {
        
        if let localrencentData = self.loadRecentArray() {
            
            return localrencentData
            
        }else{
        
        
               let array: [HMEmotion] = [HMEmotion]()
        return array
        }
    }()
    
    
    
    //加载默认表情数据
    private lazy var defaultArray:[HMEmotion] = {
        return self.loadEmotionArray(folderName: "default", fileName: "info.plist")

    }()
    //加载emj表情数据
    private lazy var emojitArray:[HMEmotion] = {
        return self.loadEmotionArray(folderName: "emoji", fileName: "info.plist")
    
    }()
    
    //加载浪小花数据
    private lazy var lxhArray:[HMEmotion] = {
        return self.loadEmotionArray(folderName: "lxh", fileName: "info.plist")
        
    }()
    
    
    //MARK:把表情数组拆分成二维数组,有参有返回值
    //  通过表情数组拆分成二维数组
    private func sectionEmoticon(emoticonArray: [HMEmotion]) -> [[HMEmotion]] {
        
        //   根据数组个数计算页数
        let pageCount = (emoticonArray.count - 1) / numberOfitemInpage + 1
        
        var tempArray = [[HMEmotion]]()
        
        //  遍历页数,截取相应数据
        for i in 0..<pageCount {
            
            //  开始截取的索引
            let loc = i * numberOfitemInpage
            //  截取的长度
            var len = numberOfitemInpage
            //  表示数组越界
            if loc + len > emoticonArray.count {
                //  获取截取剩余个数
                len = emoticonArray.count - loc
            }
            
            
            let subArray = (emoticonArray as NSArray).subarray(with: NSMakeRange(loc, len)) as! [HMEmotion]
            
            tempArray.append(subArray)
        }
        return tempArray
        
        
    }
    
    //最近表情的逻辑处理
    func SaveRecentEnotion(emotion: HMEmotion)  {
        //判断是否存在，存在删除
//        遍历数组
        for (i,etn) in recentArray.enumerated() {
             if emotion.type == "0"{
                //判断是不是图片是否存在,
                if etn.chs! == emotion.chs! {
                    recentArray.remove(at: i)
                    return
                }else{
//                    表示是emoj
                    if etn.code == emotion.code{
                        recentArray.remove(at: i)
                        return
                     
                    }
                    
                }
            
                
                
            }
            //表示不存在，插入到第一个
            recentArray.insert(emotion, at: 0)
        }
        
        //如果超过20,删除最后一个元素
        while recentArray.count > 20 {
            recentArray.removeLast()
        }
        
        //更新遍历跟新数据
        allEmotionArray[0][0] = recentArray
        
        //存储数据
      
        NSKeyedArchiver.archiveRootObject(recentArray, toFile: recentPath)
        
        
    }
    
    
    //获取沙盒路径最近表情数据
    private func loadRecentArray()->[HMEmotion]? {
        
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: recentPath) as? [HMEmotion]
    }
    
    //  根据表情描述查找默认表情数组和浪小花表情数组里面的元素
    func selectedEmoticon(chs: String) -> HMEmotion? {
        
        //  默认表情里面找
        for emoiticon in defaultArray {
            if emoiticon.chs == chs {
                return emoiticon
            }
        }
        
        //  浪小花表情里面找
        for emoticon in lxhArray {
            if emoticon.chs == chs {
                return emoticon
            }
        }
        
        
        return nil
        
    }
    
    
//END
}
