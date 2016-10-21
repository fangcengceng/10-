//
//  ViewController.m
//  添加多边形
//
//  Created by codygao on 16/10/14.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *navtext;
@property(nonatomic,strong)CLLocationManager *mgr;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController
- (IBAction)startNav:(UIButton *)sender {
    //获取起点，自定义导航地图，需要创建导航请求
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source =  [MKMapItem mapItemForCurrentLocation];
    
    //获取终点，根据导航内容而来
    //创建地理编码者
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    [coder geocodeAddressString:self.navtext.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count == 0 || error){
            NSLog(@"%@",error);
            return ;
        }
        //代码执行到此表示获取地图位置成功
        MKPlacemark *pm = [[MKPlacemark alloc] initWithPlacemark:placemarks.lastObject];
        request.destination= [[MKMapItem alloc] initWithPlacemark:pm];
        
        //创建导航对象
        MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
        //请求服务器进行路线计算
        [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
            
            //MKRout ,路线对象
            for (MKRoute *route in response.routes) {
                //添加路线折线
                [self.mapView addOverlay:route.polyline];
                
                
            }
            
            
        }];
        
        
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建地理位置管理者
     self.mgr = [[CLLocationManager alloc] init];
    if ([self.mgr respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.mgr requestWhenInUseAuthorization];
    }
    //定位精准度
    self.mgr.desiredAccuracy = kCLLocationAccuracyBest;
    self.mgr.distanceFilter = 100;

    //画折线需要地理
    self.mapView.delegate = self;
    //设置先关属性
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D)* 3);
    coords[0] = CLLocationCoordinate2DMake(29, 110);
    coords[1] = CLLocationCoordinate2DMake(30, 116);
    coords[2] = CLLocationCoordinate2DMake(23, 100);
    MKPolygon *polygon = [MKPolygon polygonWithCoordinates:coords count:3] ;
    
    [self.mapView addOverlay:polygon];
                                            
    
    
}



-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    MKPolylineRenderer *render = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    render.fillColor = [UIColor yellowColor];
    render.strokeColor = [UIColor blueColor];
    render.lineWidth = 3;
    
    
    MKPolygonRenderer *render1 = [[MKPolygonRenderer alloc] initWithOverlay:overlay];
    render1.fillColor = [UIColor redColor];
    render1.strokeColor = [UIColor blueColor];
    render1.lineWidth = 3;
    return render;
    
}


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    
    
}


@end
