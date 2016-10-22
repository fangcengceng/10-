//
//  ViewController.m
//  有梦分享
//
//  Created by codygao on 16/10/12.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <UMSocialCore/UMSocialCore.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // App Key：3377907228
    //    App Secret：8791c87765e44aee0ce5731226ba6943
    [self shareTextToWechat];
}

- (void)shareTextToWechat
{
    NSString *text = @"afajfljasd;fljkas;ldfj;askdjf;asdhf;ka";
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    messageObject.text = text;
    
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
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
}
@end
