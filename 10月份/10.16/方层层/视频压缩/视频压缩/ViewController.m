//
//  ViewController.m
//  视频压缩
//
//  Created by codygao on 16/10/16.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取视频文件
    UIImagePickerController *pickerctr = [[UIImagePickerController alloc] init];
    
    //设置来源类型
    pickerctr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //设置媒体类型
    pickerctr.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    //进行modal展示
    [self presentViewController:pickerctr animated:YES completion:nil];
    //设置代理
    pickerctr.delegate = self;
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSURL *videoURl = info[UIImagePickerControllerMediaURL];
    AVAsset *asset = [AVAsset assetWithURL:videoURl];
    //创建视图转换会话，可以将媒体资源进行转化
    AVAssetExportSession *session = [AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPresetLowQuality];
    //设置参数
    session.outputURL = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"转换视频.mp4"]];
    
    //获取支持的转化类型
    [session determineCompatibleFileTypesWithCompletionHandler:^(NSArray<NSString *> * _Nonnull compatibleFileTypes) {
        
        NSLog(@"%@",compatibleFileTypes);
    }];
    //设置转出类型
    session.outputFileType =@"public.mpeg-4";
    
    //进行视频压缩
    [session exportAsynchronouslyWithCompletionHandler:^{
        NSLog(@"完成压缩");
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
}








@end
