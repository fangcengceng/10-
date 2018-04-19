//
//  HMStatusListVIewModel.swift
//  9.19新浪微博
//
//  Created by codygao on 16/9/26.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

class HMStatusListVIewModel: NSObject {
  lazy var statusList:[HMStatsViewModel] = [HMStatsViewModel]()
    //请求微博首页数据
    func loadData(callback:@escaping (Bool)->()) -> () {
        HMNetworkTools.sharedTools.requestHomeStatusInfo(accessTocken: (HMHMUseraccountViewModel.shareduserAccountViewModel.userAccount?.access_token)!) { (response, error) in
            if error != nil {
                print("\(error),网络请求出错")
                callback(false)

                return
            }
            guard let dic = response as? [String: Any] else{
                print("字典格式有错")
                callback(false)

                return
            }
            
            guard let statusArray = dic["statuses"] as? [[String: Any]] else{
                print("你不是一个正确的字典格式")
                callback(false)
                return
            }
            
           
            
            let statusArr = NSArray.yy_modelArray(with: HMStatus.self, json: statusArray) as! [HMStatus]
            
            var tempArray = [HMStatsViewModel]()
            
            for status in statusArr{
                
                let viewModel = HMStatsViewModel(status: status)
                tempArray.append(viewModel)
            }
            //给数据源赋值
            self.statusList = tempArray
            
            
            callback(true)
           
        }
        
    }
 
    
    
    
}
