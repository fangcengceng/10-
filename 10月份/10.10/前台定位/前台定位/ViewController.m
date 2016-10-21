//
//  ViewController.m
//  前台定位
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
    
    // Do any additional setup after loading the view, typically from a nib.
    //1.一次定位    场景: 58同城&本地新闻
    //1.1创建位置管理者  统一管理定位    mgr一定进行强引用
    self.mgr = [[CLLocationManager alloc] init];
    //1.2请求授权   友情提示: 设置info.plist
    //1.2.1当应用在使用时(应用在前台)可以获取定位服务
    //版本保护
    if ( [[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
    }
    if ([self.mgr respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        [self.mgr requestWhenInUseAuthorization];
    }
    
    //    //1.2.2 始终(应用在前台&后台)可以获取定位服务  提示用户反感
    //    if ([self.mgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
    //
    //        [self.mgr requestAlwaysAuthorization];
    //    }
    //1.2.3 开启临时后台(用户可以取消) 设置后台运行模式(设置info.plist)&要求前台请求授权
    //iOS9以后还需要代码设置允许后台模式
    self.mgr.allowsBackgroundLocationUpdates = YES;
    //1.3 获取数据  设置代理
    self.mgr.delegate = self;
    //1.4 开启定位
    [self.mgr startUpdatingLocation];
    
    /**
     * 无法定位的原因:
     1.mgr没有强引用
     2.没有设置info.plist
     3.模拟器有bug  切换同版本不同设备的模拟器
     */
    
    
}

#pragma mark - CLLocationManagerDelegate


/**
 *  已经获取到定位后调用(该方法会持续返回定位数据,无论位置是否改变)
 *
 *  @param manager   位置管理者
 *  @param locations 数组<位置对象 >
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //CLLocation 位置对象 保存位置信息
    CLLocation *location = locations.lastObject;
    NSLog(@"%f,%f", location.coordinate.latitude, location.coordinate.longitude);
    //停止定位
    //    [self.mgr stopUpdatingLocation];

}

@end
