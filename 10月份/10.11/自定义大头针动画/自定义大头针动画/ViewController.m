//
//  ViewController.m
//  自定义大头针动画
//
//  Created by codygao on 16/10/11.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "HMAnotion.h"

@interface ViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
@property(nonatomic,strong)MKMapView *mapView;
@property(nonatomic,strong)CLLocationManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建地图
    self.mapView = [[MKMapView alloc] init];
    self.mapView.frame = self.view.frame;
    
    [self.view addSubview:self.mapView];
    //创建定位管理者
    self.manager = [[CLLocationManager alloc ] init];
    
    //获取授权
    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
     [self.manager requestWhenInUseAuthorization];
    }

    
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];

  //自定义后台
    self.manager.allowsBackgroundLocationUpdates = YES;
    self.manager.delegate = self;
    [self.manager startUpdatingLocation];

    
    self.mapView.showsCompass = YES;
    self.mapView.showsBuildings = YES;
    self.mapView.showsTraffic = YES;
    self.mapView.delegate = self;

}
//点击是添加自定义大头针试图
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //创建自定义大头针对象
    HMAnotion *anni = [[HMAnotion alloc] init];
    
    //获取触摸点,并将坐标点转化为地图上的左边
    UITouch *touch = touches.anyObject;
    anni.coordinate = [self.mapView convertPoint:[touch locationInView:self.view] toCoordinateFromView:self.mapView];
    
    //设置自定义大头针试图的标题和副标题
    anni.title = @"小吃街";
    anni.subtitle = @"麻辣烫";
    
    [self.mapView addAnnotation:anni];
    
    
}
//自定义大头针师徒的图片，在地图代理的协议中,系统已经处理好缓存池了,可以服用
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    //过滤系统的大头针
    if ([annotation isKindOfClass:[MKUserLocation class]]){
        //定位大头针
        return nil;
    }
    
    
    static NSString *reindentifier = @"reindentifier";
    //从地图缓存池中取出大头针
    MKAnnotationView *anniView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:reindentifier ];
    
    //有可能取不出出来，需要进行判断
    if (anniView == nil){
        anniView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reindentifier];
        
    }
    
    //设置图片
    anniView.image = [UIImage imageNamed:@"alipay_msp_op_success"];
    anniView.canShowCallout = YES;
    
    return anniView;
}



//自定义大头针动画，我们只需要实现具体的动画就可以了

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views{
    
    //遍历大头针数组
    for (MKAnnotationView *anniView in views) {
        
//        过滤大头针，系统的大头针 的定位不让其作为动画
        if ([anniView.annotation isKindOfClass:[MKUserLocation class]]){
            return ;
        }
        
        
        CGRect targetRect = anniView.frame;
        anniView.frame = CGRectMake(targetRect.origin.x, 0, targetRect.size.width, targetRect.size.height);
        [UIView animateWithDuration:1 animations:^{
            anniView.frame = targetRect;

        }];
        
        
    }
    
    
    
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    NSLog(@"ksfjs");
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    //创建地图编译者
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    [coder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count == 0 || error){
            
            NSLog(@"%@",error)
            ;
            return ;
        }
        
        //执行到此，表示反编码成功，可以给系统的大头针设置相关的而数据
        
        userLocation.title = placemarks.lastObject.thoroughfare;
        userLocation.subtitle = placemarks.lastObject.name;
        
        
    }];
    
    
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
