//
//  ViewController.m
//  聚力传感器2
//
//  Created by codygao on 16/10/18.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityStateChange) name:UIDeviceProximityStateDidChangeNotification object:nil];
   
}

-(void)proximityStateChange{
    
    //判断距离传感器的状态
    //iOS下微信语音播放之切换听筒和扬声器的方法解决方案
//如果此时手机靠近面部放在耳朵旁，那么声音将通过听筒输出，并肩屏幕变暗（省电）
    if ([UIDevice currentDevice].proximityState == YES){
        //输出扬声器
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        NSLog(@"贴脸上了");
    }else{
        NSLog(@"走远点");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
