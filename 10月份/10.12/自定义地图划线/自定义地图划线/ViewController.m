//
//  ViewController.m
//  自定义地图划线
//
//  Created by codygao on 16/10/12.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property(nonatomic,strong)CLLocationManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建位置管理者
    self.manager = [[CLLocationManager alloc] init];
    if([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.manager requestWhenInUseAuthorization];
        
    }
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    self.manager.distanceFilter = 10;
    
    [self.manager startUpdatingLocation];
    
    
    //设置覆盖物样式代理
 
    self.mapView.delegate = self;
    self.manager.delegate = self;
//    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    
    
}

- (IBAction)backAction:(UIButton *)sender {
    
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow];
    
    
}
- (IBAction)startNav:(UIButton *)sender {
  
    //获取导航请求
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];

    request.source = [MKMapItem mapItemForCurrentLocation];
    request.source.name = @"开始";
    
    //获取导航路线终点
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    [coder geocodeAddressString:self.textField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count == 0 || error){
            NSLog(@"%@",error);
            return ;
        }
        
        MKPlacemark *pm = [[MKPlacemark alloc] initWithPlacemark:placemarks.lastObject];
        
        
        request.destination = [[MKMapItem alloc] initWithPlacemark:pm];
        
        //根据导航请求，获取行驶路线
        MKDirections *direction = [[MKDirections alloc] initWithRequest:request];
        //开始计算形式路线
        [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
            if (error != nil){
                NSLog(@"%@",error);
                return ;
            }
            
            MKRoute *route = response.routes.lastObject;
//            //遍历路线
//            for (MKRouteStep *step in route.steps){
//                NSLog(@"%@",step.instructions);
//           
//            }
                 [self.mapView addOverlay:route.polyline];
            
            
        }];
        
    } ];
    
    
    
    
}

//绘制地图录像的代理
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    //创建地图覆盖物
    MKPolylineRenderer *render = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    render.lineWidth = 3;
    render.strokeColor = [UIColor redColor];
    return render;
    
    
    
    
}



@end
