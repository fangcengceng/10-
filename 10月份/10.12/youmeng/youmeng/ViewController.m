//
//  ViewController.m
//  youmeng
//
//  Created by codygao on 16/10/13.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <UMSocialCore/UMSocialCore.h>


@interface ViewController ()
//57ff0f50e0f55af30d000784App Key：528171916
//App Secret：88243ddbc20e17f4a231fe50fc07f3d2
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //分享内容
    [self shareTextToSina];
}


- (void)shareTextToSina
{
    NSString *text = @"社会化组件U-Share将各大社交平台接入您的应用，快速武装App。";
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    messageObject.text = text;
    
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        NSString *message = nil;
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        } else {
            message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
            
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
}@end
