//
//  ViewController.m
//  本地通知的快捷回复
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
   
    
    //创建动作类型
     UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
    category.identifier = @"localNote";
    
    //创建自定义按钮
    UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
    action1.title = @"我是前台按钮";
    action1.identifier = @"foregroud";
    //设置激活模式
    action1.activationMode = UIUserNotificationActivationModeForeground;
    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
    action2.title = @"我是后台按钮";
    action2.identifier = @"background";
    //iOS9快捷回复功能  场景: 在后台的按钮进行即时通信的回复
    //设置行为
    action2.behavior = UIUserNotificationActionBehaviorTextInput;
    //设置行为参数
    action2.parameters = @{UIUserNotificationTextInputActionButtonTitleKey:@"飞鸽传书"};
    
    //设置激活模式
    action2.activationMode = UIUserNotificationActivationModeBackground;
    
    
    //设置自定义按钮
    [category setActions:@[action1,action2] forContext:UIUserNotificationActionContextDefault];

    //ios8以后注册本地通知，需要系统授权
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge categories:[NSSet setWithObject:category]];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    
}


- (IBAction)fastLocalNotiRespose:(UIButton *)sender {
    
    //创建本地通知
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    //设置属性
    noti.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
    noti.alertBody = @"你好";
    noti.userInfo = @{@"content":@"欢迎回来",@"type":@1};
    //设置自定义通知
    noti.category = @"localNote";
    
    
    //通知系统开启通知
    [[UIApplication sharedApplication] scheduleLocalNotification:noti];
    
    
    
    
    
}

@end
