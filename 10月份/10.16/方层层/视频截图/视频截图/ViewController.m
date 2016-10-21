//
//  ViewController.m
//  视频截图
//
//  Created by codygao on 16/10/16.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
//定义一个视频播放器
@property(nonatomic,strong)AVPlayer *avPlayer;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
//开始播放视频
- (IBAction)startPlay:(id)sender {
    [self.avPlayer play];
}
- (IBAction)clickSnip:(id)sender {
    //截图的本质是从媒体文件中获取某个时刻的图片
    //创建媒体资源管理对象
    AVAsset *assert = [AVAsset assetWithURL:[NSURL URLWithString:@"http://baobab.wdjcdn.com/14676170652191(23).mp4"]];
    //创建图片资源生成器
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:assert];
    //获取截图时间

    NSValue *value = [NSValue valueWithCMTime:self.avPlayer.currentTime];

    //利用图片资源生成器截图
    [generator generateCGImagesAsynchronouslyForTimes:@[value] completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
        //会主线程刷新UI
       dispatch_sync(dispatch_get_main_queue(), ^{
           self.imageView.image = [UIImage imageWithCGImage:image];
       });
        
    }];
    

    
}

//懒加载avPlayer
-(AVPlayer *)avPlayer{
    //创建媒体资源对象
    
    if (_avPlayer == nil){
    
        AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:@"http://baobab.wdjcdn.com/14676170652191(23).mp4"]];
       //创建播放项目
        AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
        
        _avPlayer = [AVPlayer playerWithPlayerItem:item];
        //自己添加视图层
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
        [self.view.layer addSublayer:layer];
        layer.frame = [UIScreen mainScreen].bounds;
        
    }
    
    return _avPlayer;
    
}








@end
