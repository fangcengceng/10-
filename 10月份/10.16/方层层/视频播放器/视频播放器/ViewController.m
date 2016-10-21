//
//  ViewController.m
//  视频播放器
//
//  Created by codygao on 16/10/16.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()
//创建带UI的视频播放控制器
@property(nonatomic,strong)MPMoviePlayerViewController *vc ;

//创建不带UI的视频播放控制器
@property(nonatomic,strong)MPMoviePlayerController *playerCtr;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
//使用不带UI的视频播放器
- (IBAction)customClick:(id)sender {
    [self customPlayer];
    
}

//使用系统带UI的视频播放器
- (IBAction)systermclick:(id)sender {
    [self sytermPlayer];

}

-(void)customPlayer{
    //创建视频播放控制器,并添加到界面上显示
    NSString *path = [[NSBundle mainBundle] pathForResource:@"minion_01.mp4" ofType:nil];
    self.playerCtr = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:path]];
    
    self.playerCtr.view.frame = CGRectMake(0, 0, 300, 300);
    
    [self.view addSubview:self.playerCtr.view];
    //设置视频播放器的属性
    self.playerCtr.backgroundView.backgroundColor = [UIColor redColor];
    
    self.playerCtr.repeatMode = MPMovieRepeatModeOne;
    //控制样式
    self.playerCtr.controlStyle = MPMovieControlStyleFullscreen;
    
    //填充样式
    self.playerCtr.scalingMode = MPMovieScalingModeAspectFit;
    
    [self.playerCtr prepareToPlay];
    [self.playerCtr play];
}



-(void)sytermPlayer{
    //创建视频播放控制器
    NSString *path = [[NSBundle mainBundle] pathForResource:@"minion_01.mp4" ofType:nil];
    
    self.vc = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:path]];
    
    [self presentViewController:self.vc animated:YES completion:nil];
    
    
}

@end
