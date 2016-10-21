//
//  ViewController.m
//  短信验证
//
//  Created by codygao on 16/10/16.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <SMS_SDK/SMSSDK.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *text;

@end

@implementation ViewController
- (IBAction)getButton:(UIButton *)sender {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:@"13140103066"
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error){
                                     if (!error) {
                                         NSLog(@"获取验证码成功");
                                     } else {
                                         NSLog(@"错误信息：%@",error);
                                     }
                                 }];
 
    
    
}
- (IBAction)commit:(UIButton *)sender {
    
    [SMSSDK commitVerificationCode:self.text.text phoneNumber:@"13140103066" zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
        
        
        if (!error) {
            NSLog(@"验证成功");
        }
        else
        {
            NSLog(@"错误信息:%@",error);
        }
        
        
    }];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
