//
//  ViewController.m
//  视频播放器
//
//  Created by codygao on 16/10/17.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>//音视频播放器的类库

@interface ViewController ()

@property(nonatomic,strong)MPMoviePlayerController *playerCtr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.playerCtr play];

}

-(MPMoviePlayerController *)playerCtr{
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"minion_01.mp4" withExtension:nil];
    if (_playerCtr == nil){
        _playerCtr = [[MPMoviePlayerController alloc]initWithContentURL:url];
        _playerCtr.view.frame = CGRectMake(0, 0, 200, 200);
        _playerCtr.view.center = self.view.center;
        [self.view addSubview:_playerCtr.view];
        [_playerCtr prepareToPlay];

        _playerCtr.backgroundView.backgroundColor = [UIColor redColor];
        _playerCtr.repeatMode = MPMusicRepeatModeOne;
        _playerCtr.controlStyle = MPMovieControlStyleFullscreen;
        //填充样式
        _playerCtr.scalingMode = MPMovieScalingModeAspectFit;
        
        
     }
    
    return _playerCtr;
    
}


-(void)test{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"minion_01.mp4" withExtension:nil];
    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
    [self presentViewController:vc animated:YES completion:nil];
    
    
    
}


@end
