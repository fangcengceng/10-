//
//  ViewController.m
//  自定义本地通知
//
//  Created by codygao on 16/10/14.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置自定义类型通知
    //创建动作类型
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
   //动作类型的标识符，用于和通知进行绑定
    category.identifier = @"localNoti";
    //创建前台按钮
    UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
    action1.identifier = @"localforeground";
    action1.title = @"我是前台按钮";
    //设置激活模式
    action1.activationMode = UIUserNotificationActivationModeForeground;
    //创建后台按钮
    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
    action2.identifier = @"localbackgroud";
    action2.title = @"我是后台按钮";
    action2.activationMode = UIUserNotificationActivationModeBackground;
    //设置自定义按钮
    [category setActions:@[action1,action2] forContext:UIUserNotificationActionContextDefault];

    
    //注册授权本地通知；
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:[NSSet setWithObject:category]];
    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
   
    
}


- (IBAction)localAction:(UIButton *)sender {
    
    //创建本地通知
    UILocalNotification *localNoti = [[UILocalNotification alloc] init];
    localNoti.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
    localNoti.alertBody= @"你好";
    localNoti.userInfo = @{
                           @"content":@"欢迎回来",
                           @"indext":@1
                           };
    
    //设置对应的自定义类类型
    localNoti.category = @"localNoti";
    //预定通知,系统级别的操作;,需要注册；
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];

    
}






@end
