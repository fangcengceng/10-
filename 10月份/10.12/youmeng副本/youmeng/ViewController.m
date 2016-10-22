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
    //友盟6.0想要分享图片&短链接&音视频等必须使用SSO的方式在新浪微博放才能发送
    //分享内容
    NSString *text = @"寻找失散多年的姐妹: https://itunes.apple.com/cn/app/dong-wu-lian-tu-xiang-bian/id936613170?mt=8";
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置分享内容
    messageObject.text = text;
    //设置多媒体内容
    UMShareImageObject *imgObj = [UMShareImageObject shareObjectWithTitle:@"哈哈" descr:@"笑什么你" thumImage:[UIImage imageNamed:@"zl"]];
    //设置图片
    imgObj.shareImage = [UIImage imageNamed:@"zl"];
    messageObject.shareObject = imgObj;
    
    
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        NSString *message = nil;
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        } else {
            message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
            
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share" message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

@end
