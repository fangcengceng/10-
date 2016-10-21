//
//  AppDelegate.h
//  继承百度地图
//
//  Created by codygao on 16/10/14.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    BMKMapManager* _mapManager;

}

@property (strong, nonatomic) UIWindow *window;





@end

