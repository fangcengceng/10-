//
//  ViewController.m
//  一次新定位
//
//  Created by codygao on 16/10/10.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>
    @property(nonatomic,strong)CLLocationManager *mgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mgr = [[CLLocationManager alloc] init];
    
    //版本保护支持
//    if( [[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
//        [self.mgr requestWhenInUseAuthorization];
//    }
    
    //8.0以后需要设置，plist中需要设置,这是在前台
    if([self.mgr respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        //请求授权
        [self.mgr requestWhenInUseAuthorization];
        
    }

    
    
    
    //获取数据，设置代理
    
    self.mgr.delegate = self;
    

    

}
  
    -(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
        //开启定位
        [self.mgr startUpdatingLocation];
    }

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = locations.lastObject;
    NSLog(@"%f，，，，%f",location.coordinate.latitude,location.coordinate.longitude);
    NSLog(@"%f,%f,%f",location.altitude,location.verticalAccuracy,location.horizontalAccuracy);
//    一次性定位，开启下面这句话
//    [self.mgr stopUpdatingLocation];
    
}

@end
