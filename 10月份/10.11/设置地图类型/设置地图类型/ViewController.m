//
//  ViewController.m
//  设置地图类型
//
//  Created by codygao on 16/10/10.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<MKMapViewDelegate>
@property(nonatomic,strong)CLLocationManager *manager;
@property(nonatomic,weak)MKMapView *map;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建地图
    MKMapView *map = [[MKMapView alloc] init];
    map.frame = self.view.frame;
    
    [self.view addSubview:map];
    _map = map;
    
    //创建segement,只可以是图片或者文字
  NSString *b1 = @"1";
    NSString *b2 = @"2";

    NSString *b3 = @"3";

    NSString *b4 = @"4";

    NSString *b5 = @"5";

    NSArray *arr = [NSArray arrayWithObjects:b1,b2,b3,b4,b5, nil];

    
    UISegmentedControl *ctr = [[UISegmentedControl alloc] initWithItems:arr];
    ctr.frame = CGRectMake(0, 20, 200, 40);
    
    
    [self.view addSubview:ctr];
    
    //创建位置管理者
   self.manager =  [[CLLocationManager alloc] init];
    //授权请求,需要修改info
    if  ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.manager requestWhenInUseAuthorization];
    }
    
    //创建地图代理，请求定位数据
    map.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    
    [ctr addTarget:self action:@selector(valuechanged:) forControlEvents:UIControlEventValueChanged];
    
    map.delegate = self;
    
    NSLog(@"%@",map);
    NSLog(@"---------");
 
}

-(void)valuechanged:(UISegmentedControl*)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.map.mapType = MKMapTypeHybrid;
            break;
        case 1:
            self.map.mapType = MKMapTypeStandard;
            break;
        case 2:
            self.map.mapType = MKMapTypeHybridFlyover;
            break;
        case 3:
            self.map.mapType = MKMapTypeSatellite;
            break;
        case 4:
            self.map.mapType = MKMapTypeSatelliteFlyover;
            break;
        default:
            break;
    }
    
    
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"%@",mapView);
    NSLog(@"---------");

    NSLog(@"%@",userLocation);
    
    //创建地理编码者，是不停调用的
    
    CLGeocoder *coder= [[CLGeocoder alloc] init];
    //地理位置对象
  
    
    //反编码
    [coder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count == 0 || error){
            NSLog(@"%@",error);
            return ;
        }
        
        //代码执行到此，获取地标对象成功
        CLPlacemark *pm = placemarks.lastObject;
        
        //获取大头针定位
        userLocation.title = pm.name;
        userLocation.subtitle = pm.subLocality;
    
        
        
        
        
    }];
    
    
    
    
    
}



@end
