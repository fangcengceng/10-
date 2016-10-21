//
//  ViewController.m
//  音乐播放
//
//  Created by codygao on 16/10/17.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
//创建音乐播放
@property(nonatomic,strong)AVAudioPlayer *audioPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)startPlay:(id)sender {
   
    //懒加载必须调用self方法，否则不会调用懒加载
    [self.audioPlayer play];
    
    
}

- (IBAction)pausePlay:(id)sender {
    [self.audioPlayer pause];
}
- (IBAction)stopPlay:(id)sender {
    self.audioPlayer = nil;
}

-(AVAudioPlayer *)audioPlayer{
    if (_audioPlayer == nil){
      
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"李克勤 - 月半小夜曲.mp3" ofType:nil];
        
        
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath] error:nil];
        [_audioPlayer prepareToPlay];
    }
    
    return  _audioPlayer;
    
}

@end
