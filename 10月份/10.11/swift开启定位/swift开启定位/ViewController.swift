//
//  ViewController.swift
//  swift开启定位
//
//  Created by codygao on 16/10/11.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate {
 
    // 声明一个全局变量
         var locationManager:CLLocationManager!
   
       override func viewDidLoad() {
           super.viewDidLoad()
              locationManager = CLLocationManager()
      
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.distanceFilter = 50
        

     
                        locationManager.requestWhenInUseAuthorization()
                    
                locationManager.delegate = self;
               if CLLocationManager.locationServicesEnabled(){
                        locationManager.startUpdatingLocation()
                    }else{
                  print("没有定位服务")
                   }
       
             }
       // 定位失败调用的代理方法
         func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
                 print(error)
            }
       // 定位更新地理信息调用的代理方法
         func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                 if locations.count > 0
                {
                         let locationInfo = locations.last!
                        let alert:UIAlertView = UIAlertView(title: "获取的地理坐标",
                                                                          message: "经度是：\(locationInfo.coordinate.longitude)，维度是：\(locationInfo.coordinate.latitude)",
                                                                              delegate: nil, cancelButtonTitle: "是的")
                      alert.show()
                     }
           }
    }