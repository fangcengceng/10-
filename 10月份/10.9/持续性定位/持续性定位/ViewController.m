//
//  ViewController.m
//  持续性定位
//
//  Created by codygao on 16/10/10.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *manager;
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1、创建定位管理者
    self.manager = [[CLLocationManager alloc] init];
    
    //获取授权,ios8.0版本以上需要申请授权
        if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
    
            [self.manager requestWhenInUseAuthorization];
    
        }
    
    //进入后台后依旧支持定位
    if ([self respondsToSelector:@selector(requestAlwaysAuthorization)]){
        
        [self.manager requestAlwaysAuthorization];
    }
    [self.manager allowsBackgroundLocationUpdates];
    
    
    
    
    //获取数据
    _manager.delegate = self;
    
    //开启定位，默认持续定位
    
    //持续定位优化
    //期望精准度
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    //    距离筛选器，减少不必要的更新次数
    self.manager.distanceFilter = 10;
    
}
    -(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
        [self.manager startUpdatingLocation];

    }
    -(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
        
        //创建位置对象
        CLLocation *location = locations.lastObject;
        NSLog(@"%f",location.coordinate.longitude);
        
        
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
