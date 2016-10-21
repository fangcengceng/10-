//
//  ViewController.swift
//  swift大头针动画
//
//  Created by codygao on 16/10/11.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    var manager: CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        let mapview = MKMapView()
        mapview.frame = view.frame
        view.addSubview(mapview)
        
        //开始定位
       manager = CLLocationManager()
        
        //获取授权,配置plist
        if manager.respondsToSelector(#selector(manager.requestWhenInUseAuthorization)){
              manager.requestWhenInUseAuthorization()
        
        }
        manager.delegate = self
        manager.startUpdatingLocation()
        
        
        
        
        
        //获取mapView的相关属性
        mapview.userTrackingMode = .Follow
        
        mapview.showsCompass = true
        mapview.showsUserLocation = true
        mapview.showsBuildings = true
   
        mapview.delegate = self;
        
        
    
    
    }
    
    //定位失败
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    
    
    //定位更新地理信息
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0{
           print(locations.last?.coordinate.latitude)
           print("--------------")
        }
        
    }

    


}

