//
//  ViewController.m
//  系统地图导航
//
//  Created by codygao on 16/10/12.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()
@property(nonatomic,weak)UITextField *textfield;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setupUI];
    [self showMapItemsInSystemMap];
    
}
-(void)setupUI{
    UITextField *field = [[UITextField alloc] initWithFrame: CGRectMake(0, 0, 300, 40)];
    [field setBorderStyle:UITextBorderStyleRoundedRect];
    [field setPlaceholder:@"请输入目的地"];
    [self.view addSubview:field];
    self.textfield = field;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.center = self.view.center;
    [button sizeToFit];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(startNavi) forControlEvents:UIControlEventTouchUpInside];
}

//设置导航路线
-(void)startNavi{
    //导航起点
 
    MKMapItem *start = [MKMapItem mapItemForCurrentLocation];
    
    //获取导航终点
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    [coder geocodeAddressString:self.textfield.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        MKPlacemark *pm = [[MKPlacemark alloc] initWithPlacemark:placemarks.lastObject];
        //导航终点
        MKMapItem *dest = [[MKMapItem alloc] initWithPlacemark:pm];
        
        
        //打开地图
        NSDictionary *option = @{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsMapTypeKey:[NSNumber numberWithUnsignedInteger: MKMapTypeStandard]};
        [MKMapItem openMapsWithItems:@[start,dest] launchOptions:option];
        
    }];
    
}

//在地图上显示某个点
-(void)showMapItemsInSystemMap{
    MKMapItem *start = [MKMapItem mapItemForCurrentLocation];
    start.name = @"xiaochijie";
    start.phoneNumber = @"010-1111";
    start.url = [NSURL URLWithString:@"http://www.baidu.com"];
    [start openInMapsWithLaunchOptions:nil];
    
    //创建里一个地图点
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    [coder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:39 longitude:111] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count == 0 || error){
            NSLog(@"%@",error);
            return ;
        }
        
        MKPlacemark *pm = [[MKPlacemark alloc] initWithPlacemark:placemarks.lastObject];
        
        MKMapItem *item2 = [[MKMapItem alloc] initWithPlacemark:pm];
        item2.name = @"系统地图";
        item2.phoneNumber = @"11111";
        
        //在地图上显示item2这个点
        
        [item2 openInMapsWithLaunchOptions:nil];
        
        
        
    }];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
