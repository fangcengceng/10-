//
//  ViewController.m
//  自定义地图导航
//
//  Created by codygao on 16/10/12.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()
@property(nonatomic,weak)UITextField *field;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic,strong)CLLocationManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建地理位置管理者并且获取授权
    self.manager = [[CLLocationManager alloc] init];
    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.manager requestWhenInUseAuthorization];
    }
    

    [self setupUI];
}

-(void)setupUI{
    //创建输入框
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    field.center = self.view.center;
    [field setBorderStyle:UITextBorderStyleRoundedRect];
    [field setPlaceholder:@"请输入目的地"];
    field.text = @"天安门";
    
    [self.view addSubview:field];
    self.field = field;
    
    //创建导航按钮
    UIButton *bu = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 100, 20)];
    [bu addTarget:self action:@selector(startNav) forControlEvents:UIControlEventTouchUpInside];
    [bu setTitle:@"开始查询" forState:UIControlStateNormal];
    [bu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bu.backgroundColor = [UIColor redColor];
    [self.view addSubview:bu];
    
}

-(void)startNav{
    //创建自定义地图导航对象
    //获取授权
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    
    //获取定位点
    [request setSource: [MKMapItem mapItemForCurrentLocation]];
    
    //获取另一个目标点
    CLGeocoder *coder = [[CLGeocoder alloc] init];
   [coder geocodeAddressString:self.field.text  completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
       MKPlacemark *pm = [[MKPlacemark alloc] initWithPlacemark:placemarks.lastObject];
       
       request.destination =[[MKMapItem alloc] initWithPlacemark:pm];
//       
//       //这是查询具体一个点,这一句代码代表系统的地图，优先级高，走完了，就不会再走下面的代码
//       [request.destination openInMapsWithLaunchOptions:nil];
       
       
//       //创建导航对象
       MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
       
       //开始计算导航路线
       [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
           //获取路线对象
           MKRoute *route = response.routes.lastObject;
           
           //遍历
           for (MKRouteStep *step in route.steps){
               
               NSLog(@"%@",step.instructions);
               
           }
           
       }];
       
       
       

   }];
    
    
    
    
    
    
    
    
    
}

@end
