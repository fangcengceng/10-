//
//  ViewController.m
//  指纹识别
//
//  Created by codygao on 16/10/16.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //创建上下文
    LAContext *context = [[LAContext alloc] init];
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]){
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请求指纹识别" reply:^(BOOL success, NSError * _Nullable error) {
            if (success){
                NSLog(@"指纹验证成功");
            }else{
                NSLog(@"指纹验证失败");
            }
            
        }];
    }else{
        
        NSLog(@"手机不识别指纹验证");
    }
    
    
}

@end
