//
//  ViewController.m
//  自定义后台
//
//  Created by codygao on 16/10/10.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *mgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mgr = [[CLLocationManager alloc] init];
    
    //请求授权
    if ([self.mgr respondsToSelector:@selector(requestWhenInUseAuthorization) ]){
        [self.mgr requestWhenInUseAuthorization];
    }

    self.mgr.allowsBackgroundLocationUpdates = YES;
    self.mgr.delegate = self;
    [self.mgr startUpdatingLocation];


}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"%f",locations.lastObject.coordinate.latitude);
}

@end
