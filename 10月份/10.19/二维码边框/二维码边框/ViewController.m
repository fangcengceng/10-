//
//  ViewController.m
//  二维码边框
//
//  Created by codygao on 16/10/18.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <SafariServices/SafariServices.h>
#import "HMPreviouView.h"


@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>
//输入设备
@property(nonatomic,strong)AVCaptureDeviceInput *deviceInput;
//二维码输出设备
@property(nonatomic,strong)AVCaptureMetadataOutput *metadaOutdata;
//创建输入输出会话
@property(nonatomic,strong)AVCaptureSession *session;
//创建预览视图层
//@property(nonatomic,strong)AVCaptureVideoPreviewLayer *previewLayer;

//自定义HMPreviouView;
@property(nonatomic,strong)HMPreviouView *previousView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    self.metadaOutdata = [[AVCaptureMetadataOutput alloc] init];
    //设置代理
    [self.metadaOutdata setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //给会话添加输入输出设备
    [self.session addInput:self.deviceInput];
    [self.session addOutput:self.metadaOutdata];
    //设置二维码的type
    self.metadaOutdata.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
//    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
//    [self.view.layer addSublayer:self.previewLayer];
//    self.previewLayer.bounds = [UIScreen mainScreen].bounds;
    HMPreviouView *previousView = [[HMPreviouView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    previousView.session = self.session;
    
    [self.view addSubview:previousView];
    self.previousView = previousView;
   //启动会话
    [self.session startRunning];
    

}


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    for (AVMetadataMachineReadableCodeObject *obj in metadataObjects) {
        if ([obj.stringValue hasPrefix:@"http://"]){
            SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:obj.stringValue]];
            [self presentViewController:vc animated:YES completion:nil];
        }else{
            NSLog(@"%@",obj.stringValue);
        }
        
        [self.session stopRunning];
//        [self.previewLayer removeFromSuperlayer];
        [self.previousView removeFromSuperview];

    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
