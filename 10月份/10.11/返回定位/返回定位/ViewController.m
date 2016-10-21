//
//  ViewController.m
//  返回定位
//
//  Created by codygao on 16/10/10.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapVIew;
@property(nonatomic,strong)CLLocationManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //开启定位
    self.manager = [[CLLocationManager alloc] init];
    
    //申请授权,需要在plist文件中设置；
    if ([self.manager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        [self.manager requestAlwaysAuthorization];
        
    }
    
  
    //设置地图跟踪模式
    self.mapVIew.userTrackingMode = MKUserTrackingModeFollow;
    //设置代理
    self.mapVIew.delegate = self;
    self.mapVIew.camera = [MKMapCamera cameraLookingAtCenterCoordinate:CLLocationCoordinate2DMake(40, 115)  fromDistance:30 pitch:20 heading:0];
    
    
    //属性
    self.mapVIew.showsScale = YES;
    self.mapVIew.showsCompass = YES;
    self.mapVIew.showsTraffic = YES;
    self.mapVIew.showsBuildings = YES;
    self.mapVIew.showsUserLocation = YES;
    self.mapVIew.showsPointsOfInterest = YES;
    
    
}
//设定返回定位
- (IBAction)backButton:(UIButton *)sender {
    //方法一
    [self.mapVIew setUserTrackingMode:MKUserTrackingModeFollow animated:YES ];
    //设定中心
    CLLocationCoordinate2D center = self.mapVIew.userLocation.location.coordinate ;
    //设定范围
    MKCoordinateSpan span = self.mapVIew.region.span;
    
    
  [self.mapVIew setRegion:MKCoordinateRegionMake(center, span) animated:YES];
    
    
}


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    //大头针
    
    //创建编码管理者
    
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    [coder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        //判断
        if (placemarks.count == 0 || error){
            NSLog(@"%@",error);
            return ;
        }
        userLocation.title = placemarks.lastObject.name;
        userLocation.subtitle = placemarks.lastObject.subLocality;
        
    }];
    
    
    
    
    
}


@end
