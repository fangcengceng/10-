//
//  ViewController.m
//  视频录制
//
//  Created by codygao on 16/10/16.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic,strong) AVCaptureDeviceInput *videoInput;
//
@property(nonatomic,strong)AVCaptureDeviceInput *audioInput;
@property(nonatomic,strong)AVCaptureMovieFileOutput *fileout;
@property(nonatomic,strong)AVCaptureSession *sesion;
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *presentlayer;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AVCaptureDevice *vider = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDevice *audio = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    //输入设备: 摄像头
    self.videoInput = [AVCaptureDeviceInput deviceInputWithDevice:vider error:nil];
    //输入设备2：麦克风
    self.audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audio error:nil];
    //输出设备 ：视频文件
    self.fileout = [[AVCaptureMovieFileOutput alloc] init];
    //会话：管理输入和输出设备
    self.sesion = [[AVCaptureSession alloc] init];
    
    if ([self.sesion canAddInput:self.videoInput]){
        [self.sesion addInput:self.videoInput];
    }
    if ([self.sesion canAddInput:self.audioInput]){
        [self.sesion addInput:self.audioInput];
    }
    if ([self.sesion canAddOutput:self.fileout]){
        [self.sesion addOutput:self.fileout];
    }
    
    self.presentlayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.sesion];
    [self.view.layer insertSublayer:self.presentlayer atIndex:0];
    self.presentlayer.frame = [UIScreen mainScreen].bounds;
    //开始会话
    [self.sesion startRunning];

}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UIImagePickerController 公共的视频和图片路径
    UIImagePickerController *pickerControlelr = [[UIImagePickerController alloc] init];
    //设置来源类型
    pickerControlelr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerControlelr.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:pickerControlelr animated:YES completion:nil];
    pickerControlelr.delegate = self;
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    
    
    
}





@end
