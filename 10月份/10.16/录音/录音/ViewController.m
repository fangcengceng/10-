//
//  ViewController.m
//  录音
//
//  Created by codygao on 16/10/17.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property(nonatomic,strong)AVAudioRecorder *recorder;
@property(nonatomic,strong)CADisplayLink *linker;
@property(nonatomic,assign) int time;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //检测录音的声音变化
    self.recorder.meteringEnabled = YES;
    //定时器
    self.linker = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateMeters)];

}
-(void)updateMeters{
    //跟新声音变化
    [self.recorder updateMeters];
    float power = [self.recorder peakPowerForChannel:0];
    NSLog(@"%f",power);
    if (power <= -20){
        self.time ++ ;
        if (self.time >=120){
            [self.recorder stop];
            [self.linker invalidate];
        }
    }else{
        self.time = 0;
    }
    
    
}

- (IBAction)start:(id)sender {
    [self.recorder record];
}
- (IBAction)pause:(id)sender {
    [self.recorder pause];
}
- (IBAction)stop:(id)sender {
    [self.recorder stop];
}

-(AVAudioRecorder *)recorder{
    if (_recorder == nil){
        NSString *path = @"/Users/codygao/Desktop/123.caf";
        
        NSDictionary *dic = @{
                              AVSampleRateKey: @441000,
                              AVNumberOfChannelsKey: @0,
                              AVLinearPCMBitDepthKey: @16
                              };
        //设置录音对象
        _recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:path] settings:dic error:nil];
        //设置缓冲
        [_recorder prepareToRecord];
    }
    
    return  _recorder;
    
    
}

@end
