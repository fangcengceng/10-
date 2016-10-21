//
//  ViewController.m
//  地图基本使用1
//
//  Created by codygao on 16/10/10.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
@interface ViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    //创建地图
    [super viewDidLoad];
    MKMapView *map = [[MKMapView alloc] init];
    map.frame = self.view.frame;
    [self.view addSubview:map];
    
    //创建位置管理者，强引用，获取授权
    self.manager = [[CLLocationManager alloc] init];
    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.manager requestWhenInUseAuthorization];
    }
    self.manager.allowsBackgroundLocationUpdates = YES;

    self.manager.delegate = self;
    [self.manager startUpdatingLocation];
    //创建地图用户跟踪模式
    map.userTrackingMode = MKUserTrackingModeFollow;
    
    //获取实时更新数据，需要设置代理
    map.delegate = self;
    
    
}
//定位的代理；默认在子线程执行；
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    NSLog(@"%f",locations.lastObject.verticalAccuracy);
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    //大头针模型 MKUserLocation
    
    //创建地理编码者,调用方法，才能获取地表对象数组，获取地理信息和人文信息,
    CLGeocoder *gecoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] init];
    [gecoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        //编码和反编码也是在这个方法中
        if (placemarks.count == 0 || error){
            NSLog(@"%@",error);
            return ;
        }
        
        //获取地标对象,
        CLPlacemark *pm = placemarks.lastObject;
        //大头针标题
        userLocation.title = pm.name;
        userLocation.subtitle = pm.subThoroughfare;
        
        
        
        
        
        
    } ];
    
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
