//
//  ViewController.m
//  音效播放
//
//  Created by codygao on 16/10/16.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
//音乐播放器
@property(nonatomic,strong) AVAudioPlayer *audioplayer;

//录音
@property(nonatomic,strong) AVAudioRecorder *recorder;
//精准的定时器
@property(nonatomic,strong)CADisplayLink *playLink;
//
@property(nonatomic,assign)NSInteger muteTime;


@end

@implementation ViewController{

    NSMutableDictionary *_systermIdDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

#warning 播放音效
//存储音频的容器懒加载试着是get方法
-(NSMutableDictionary*)systemIdDic{
    
    if (_systermIdDic == nil ){
        _systermIdDic = [[NSMutableDictionary alloc] init];
        
    }
    return  _systermIdDic;
}

-(void)playsystermSoundWithFileName:(NSString *)fileName{
    //逻辑是先从缓存池中去，如果存在就赋值，
    SystemSoundID systemId;
    //先从缓存池中取出来
    systemId = [[_systermIdDic valueForKeyPath:fileName] intValue];
    //判断是否存在如果不存在就创建
    if (systemId == 0){
        
        //根据文件路径生成音效路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:filePath];
        //生成音效,参数一：音效路径，参数二：系统声音地址
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &systemId);
        //    NSLog(@"%u",systemId);
        //将其添加到缓存池中
        [_systermIdDic setValue:@(systemId) forKey:fileName];
    }
    //播放音效
    AudioServicesPlaySystemSound(systemId);
    
}


//播放音效
- (IBAction)playsystermSound:(UIButton *)sender {

    [self playsystermSoundWithFileName:@"buyao.caf"];
}




#warning 播放音乐
-(AVAudioPlayer*)audioplayer{

    if (_audioplayer == nil){

        //方法一：
        NSURL *URL = [[NSBundle mainBundle] URLForResource:@"我爱你你却爱着她.mp3" withExtension:nil];
        _audioplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:URL error:nil];
        //方法二：
        //        NSString *path = [[NSBundle mainBundle]pathForResource:@"我爱你你却爱着她.mp3" ofType:nil];
//        _audioplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
        [_audioplayer prepareToPlay];
    }
    return  _audioplayer;
    
}
//播放音乐
- (IBAction)play:(UIButton *)sender {
    [[self audioplayer] play];
    NSLog(@"sss");
    
}
- (IBAction)pause:(UIButton *)sender {

    //暂停之后继续缓存，点击继续之后继续往下播放
    [self.audioplayer pause];
}
- (IBAction)stop:(UIButton *)sender {
//    [_player stop];

    self.audioplayer = nil;
}

//接受到内存警告时，清空缓存
-(void)didReceiveMemoryWarning{
    //销毁
    for (NSNumber *num in _systermIdDic.allValues){
        AudioServicesDisposeSystemSoundID([num unsignedIntValue]);
    }
    //清空缓存
    _systermIdDic = nil;
    
}


#warning 录制音频
-(void)prepareTask{
   
    
}

-(void)updatePeakPower{
    [self.recorder updateMeters];
    float peakPower = [self.recorder peakPowerForChannel:0];
    
    //需求是精英两秒就自动停止录音
    if (peakPower <= -40){
        self.muteTime += 1;
        if (self.muteTime >120){
            [self.recorder stop];
            //定时器停止
            [self.playLink invalidate];
        }
    }else{
        self.muteTime = 0;
    }
    
}

//开始录制
- (IBAction)record:(UIButton *)sender {
    //存储路径
    NSString *filepath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    NSLog(@"%@",filepath);
    
    NSDictionary *setting = @{AVSampleRateKey: @8000,
                              AVLinearPCMBitDepthKey:@16};
    self.recorder = [[AVAudioRecorder alloc] initWithURL:[[NSURL fileURLWithPath:filepath] URLByAppendingPathComponent:@"123.caf"] settings:setting error:nil];
    [self.recorder prepareToRecord];
    //开始测量，获取分贝波动
    self.recorder.meteringEnabled = YES;
    
    //实例化定时器
    self.playLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updatePeakPower)];
    [self.recorder record];
    
}



- (IBAction)recordPause:(UIButton *)sender {
    [self prepareTask];

    [self.recorder pause];
}

- (IBAction)recordStop:(UIButton *)sender {
    [self prepareTask];

    [self.recorder stop];
    
}




@end
