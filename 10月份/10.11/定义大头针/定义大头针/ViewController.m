//
//  ViewController.m
//  定义大头针
//
//  Created by codygao on 16/10/11.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "HMAnnotion.h"

@interface ViewController ()<MKMapViewDelegate>
@property(nonatomic,strong) CLLocationManager *manager;
@property(nonatomic,weak)MKMapView *mapView;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    MKMapView *mapView = [[MKMapView alloc] init];
    mapView.frame = self.view.frame;
    [self.view addSubview:mapView];
    self.mapView = mapView;
//    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //创建地图定位
   self.manager = [[CLLocationManager alloc] init];
    //获取后台
    if([self.manager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        [self.manager requestAlwaysAuthorization];
    }
    //获取前台授权
    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.manager requestWhenInUseAuthorization];
    }
    
    self.mapView.delegate = self;
    self.mapView.showsCompass = YES;
    self.mapView.showsTraffic = YES;
   
   

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //设置自定义大头针对象的数据
    HMAnnotion *annotion = [[HMAnnotion alloc] init];
    annotion.title = @"麻辣烫";
    annotion.subtitle = @"小吃街";
  
    //将触摸点转化为地图坐标点
    //获取坐标点
    UITouch *touch = touches.anyObject ;
    annotion.coordinate = [self.mapView convertPoint:[touch locationInView:self.mapView ] toCoordinateFromView:self.mapView];
    
    //给地图添加大头针对象
    [self.mapView addAnnotation:annotion];
    

    
    
    
}



-(void)backAction:(UIButton*)sender{
    //方法一设置返回定位
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    
    //方法二设置返回定位
    CLLocationCoordinate2D center = self.mapView.userLocation.location.coordinate;
    MKCoordinateSpan span = self.mapView.region.span;
    
    
    [self.mapView setRegion:MKCoordinateRegionMake(center, span) animated:YES];
     
     }

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    //创建地理编译者
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    [coder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
    
        if (placemarks.count == 0 || error){
            NSLog(@"%@",error);
            return ;
        }
    
    
        userLocation.title = placemarks.lastObject.subLocality;
        userLocation.subtitle = placemarks.lastObject.name;
        
    }];
    
    
    
}



@end
