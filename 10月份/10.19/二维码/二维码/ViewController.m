//
//  ViewController.m
//  二维码
//
//  Created by codygao on 16/10/18.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <SafariServices/SafariServices.h>

@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property(nonatomic,strong)AVCaptureDeviceInput *input ;
@property(nonatomic,strong)AVCaptureMetadataOutput *output;

@property(nonatomic,strong)AVCaptureSession *session;
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *priviewLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    self.session = [[AVCaptureSession alloc] init];
    [self.session addInput:_input];
    [self.session addOutput:self.output];
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    [self.view.layer addSublayer:self.priviewLayer];
    self.priviewLayer.frame = [UIScreen mainScreen].bounds ;
    [self.session startRunning];

}
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    for (AVMetadataMachineReadableCodeObject *obj in metadataObjects){
//        创建内嵌的浏览器功能
        if ([obj.stringValue hasPrefix:@"http://"]){
        
           SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL: [NSURL URLWithString:obj.stringValue]];
            [self presentViewController:vc animated:YES completion:nil];
        
        }else{
            NSLog(@"%@",obj.stringValue);
        }
        NSLog(@"%@",[obj class]);
        //移除会话
        [self.session stopRunning];
        //移除预览
        [self.priviewLayer removeFromSuperlayer];
        return;
        
    }
    
    
    
}


@end
