//
//  ViewController.m
//  地图导航
//
//  Created by codygao on 16/10/12.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];



}
- (IBAction)startNav:(UIButton *)sender {
    
    //获取导航定位点
    MKMapItem *sourth = [MKMapItem mapItemForCurrentLocation];
    NSLog(@"%f",sourth.placemark.coordinate.longitude);
    
    //获取目标定位点，是文本框中的内容个，需要编码
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    [coder geocodeAddressString:self.textField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        //判断
        if (placemarks.count == 0 || error){
            NSLog(@"%@",error);
            return ;
        }
        
        CLPlacemark *location = placemarks.lastObject;
        //将其zhuanhua为子类
        //MKPlacemark ,继承自地标对象，需要将地标对象进行转化
        MKPlacemark *pm = [[MKPlacemark alloc] initWithPlacemark:location];
        //终点,需要地标对象
        MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:pm];
        
        //打开地图,需要设置起点终点数组，导航选择方式
        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsMapTypeKey:[NSNumber numberWithUnsignedInteger:MKMapTypeStandard]};
        [MKMapItem openMapsWithItems:@[sourth,destination] launchOptions:launchOptions];
        
        
        
    }];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
