//
//  ViewController.m
//  视频录制一
//
//  Created by codygao on 16/10/16.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVCaptureFileOutputRecordingDelegate>
@property(nonatomic,strong)AVCaptureDeviceInput *audioInput;
@property(nonatomic,strong)AVCaptureDeviceInput *videoInput;
@property(nonatomic,strong)AVCaptureMovieFileOutput *output;
//会话，管理输入和输出设备
@property(nonatomic,strong)AVCaptureSession *session;
//展示摄像头预览图
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//设置设备类型
    AVCaptureDevice *audie = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDevice *video = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //实例化输入和输出设备
    self.audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audie error:nil];
    self.videoInput = [AVCaptureDeviceInput deviceInputWithDevice:video error:nil];
    self.output = [[AVCaptureMovieFileOutput alloc] init];
    self.session = [[AVCaptureSession alloc] init];
    
    //给会话添加输入和输出设备
    if([self.session canAddInput:self.audioInput]){
        [self.session addInput:self.audioInput];
    }
    if ([self.session canAddInput:self.videoInput]){
        [self.session addInput:self.videoInput];
        
    }

    if ([self.session canAddOutput:self.output]){
        [self.session addOutput:self.output];
    }

    //展示摄像头的预览视图
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    //将摄像头的预览视图添加到视图中
    [self.view.layer insertSublayer:self.previewLayer atIndex:0 ];
    self.previewLayer.frame = [UIScreen mainScreen].bounds;
    
    //开启会话
    [self.session startRunning];
    
    
}
//开始录制视频
- (IBAction)startRecord:(id)sender {
    
    //确定输出路径
    NSString *filepath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"123.mp4"];
    
    //开始录制
    [self.output startRecordingToOutputFileURL:[NSURL fileURLWithPath:filepath] recordingDelegate:self];
    
    
    
}
//结束录制视频
- (IBAction)endRecord:(id)sender {
    
    [self.output stopRecording];
    //停止会话
    [self.session stopRunning];
    //移除视图
    [self.previewLayer removeFromSuperlayer];
}
//代理方法
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    NSLog(@"开始录制");
}

-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    NSLog(@"结束录制");
}


@end
