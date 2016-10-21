//
//  ViewController.m
//  传感器
//
//  Created by codygao on 16/10/18.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Accelerate/Accelerate.h>
#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
typedef enum : NSUInteger {
    HMSessionAudio,
    HMSessionVideo,
} HMSessionType;
@interface ViewController ()<UIAccelerometerDelegate>
@property(nonatomic,strong)CMMotionManager *mgr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)jibuqi{
    CMStepCounter *stempcounter = [[CMSensorDataList alloc] init];
    [stempcounter startStepCountingUpdatesToQueue:[NSOperationQueue mainQueue] updateOn:10 withHandler:^(NSInteger numberOfSteps, NSDate * _Nonnull timestamp, NSError * _Nullable error) {
        
    }];
}
//摇一摇
-(void)yaoyiyao{
//    1、采用系统封装的方式
//    2、设置加速计的摇动范围，在这个范围之外就认为产生了摇一摇事件
    
}
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
}

//陀螺仪
-(void)test4{
    self.mgr =[[CMMotionManager alloc] init];
    self.mgr.gyroUpdateInterval = 1.0;
    [self.mgr startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
        CMRotationRate rotationRaTate = gyroData.rotationRate;
        NSLog(@"%f%f%f",rotationRaTate.x,rotationRaTate.y,rotationRaTate.z);
        
    }];
    
    
}


//磁力计
-(void)test5{
    self.mgr = [[CMMotionManager alloc] init];
    self.mgr.magnetometerUpdateInterval = 1.0;
    [self.mgr startMagnetometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMMagnetometerData * _Nullable magnetometerData, NSError * _Nullable error) {
        
        CMMagneticField filed = magnetometerData.magneticField;
        NSLog(@"%f%f%f",filed.x,filed.y,filed.z);
    }];
    
}


//按需获取传感器数据
-(void)test3{
    self.mgr = [[CMMotionManager alloc] init];
    [self.mgr accelerometerUpdateInterval];
    CMAcceleration accelation = self.mgr.accelerometerData.acceleration;
    NSLog(@"%f",accelation.x);

}


//运动管理器
-(void)test2{
  self.mgr = [[CMMotionManager alloc] init];
    //设置采样率
    self.mgr.accelerometerUpdateInterval = 1.0;
    //开始检测
    /*
     运动传感器的传感器数据有两种获取数据，  
     1、push  系统主动返回数据给开发者，实时性强，好点多，一旦设置了采样率，就认为采用了push方式
     2、pull方式，按需获取，耗电低；

     
    */

    [self.mgr startAccelerometerUpdates];//自己获取传感器数据
    //系统返回传感器数据
    [self.mgr startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        CMAcceleration accestion = accelerometerData.acceleration;
        NSLog(@"%f%f%f",accestion.x,accestion.y,accestion.z);
    }];
}


//加速计(摇一摇，计步器),已过时
-(void)test1{
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer] ;
    //设置采样率
    accelerometer.updateInterval = 1.0f;
    accelerometer.delegate = self;
    
    
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    
    NSLog(@"%f%f%f",acceleration.x,acceleration.y,acceleration.z);
}

//近距离传感器，封装在设备的类里
-(void)test{
    //近距离检测
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityStateChange) name:UIDeviceProximityStateDidChangeNotification object:nil];
    
    //使用场景：音视频会话
    
    NSUInteger sessionType = 0;
    switch (sessionType) {
        case 0:

            [UIDevice currentDevice].proximityMonitoringEnabled = YES;
            break;
        case 1:
            
            [UIDevice currentDevice].proximityMonitoringEnabled = NO;
            //不锁屏
            [UIApplication sharedApplication].idleTimerDisabled = NO;
            break;
            
        default:
            break;
    }

}
//监听传感器
-(void)proximityStateChange{
    if ([UIDevice currentDevice].proximityState == YES){
        NSLog(@"铁脸上了");
    }else{
        NSLog(@"zouyuandian");
    }
    
}















@end
