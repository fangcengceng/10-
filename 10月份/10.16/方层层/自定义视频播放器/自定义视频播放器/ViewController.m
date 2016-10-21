//
//  ViewController.m
//  自定义视频播放器
//
//  Created by codygao on 16/10/16.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h> //音视频的类

@interface ViewController ()
@property(nonatomic,strong)MPMoviePlayerController *playctr;
@property(nonatomic,strong)AVPlayer *avPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exsitFullScreen) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
 
}
-(void)exsitFullScreen{
    if (self.playctr.playbackState ==MPMoviePlaybackStatePaused ){
        
        [self.playctr.view removeFromSuperview];
    }
    
}

- (IBAction)mpmovieClick:(id)sender {
    
 

    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"minion_01.mp4" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    MPMoviePlayerController *playctr = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    [self.view addSubview:playctr.view];
    playctr.view.frame = CGRectMake(0, 0, 400, 400);
    
    [playctr prepareToPlay];
     playctr.backgroundView.backgroundColor = [UIColor redColor];


    playctr.controlStyle = MPMovieControlStyleEmbedded;
    playctr.scalingMode = MPMovieScalingModeAspectFit;
    playctr.repeatMode = MPMovieRepeatModeOne;
    

    
    //添加button
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [bu addTarget:self action:@selector(clickFullScreen:) forControlEvents:UIControlEventTouchUpInside];
    [playctr.view addSubview:bu];


    self.playctr = playctr;
}
//监听点击全屏按钮
-(void)clickFullScreen:(UIButton*)bu{
    
    [UIView animateWithDuration:1 animations:^{
        self.playctr.view.transform = CGAffineTransformRotate(self.playctr.view.transform, M_PI_2);
        self.playctr.view.frame = [UIScreen mainScreen].bounds;
        
    }];
    
    
}

//使用AVFoundation
- (IBAction)avPlayer:(id)sender {
   
    //调用AVPlayer的get方法；
    [self.avPlayer play];
    
    
    
}

//懒加载不能用 self.avPlayer ,不然去调用get方法，会造成递归；
-(AVPlayer *)avPlayer{
    if (_avPlayer == nil){
        //创建媒体资源对象，代表播放给的文件
        AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:@"http://baobab.wdjcdn.com/14676170652191(23).mp4"]];
        //创建播放项目
        AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
        //创建播放器
        _avPlayer = [[AVPlayer alloc] initWithPlayerItem:item];
        //添加视图
        AVPlayerLayer *playerlayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
        //添加到主视图的layer上
        [self.view.layer addSublayer:playerlayer];
        
        playerlayer.frame = [UIScreen mainScreen].bounds;
    }
    return _avPlayer;
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.avPlayer =nil;
    
    
}

@end
