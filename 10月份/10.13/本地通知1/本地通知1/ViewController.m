//
//  ViewController.m
//  本地通知1
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
    
   //添加普通通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi) name:@"name" object:nil];
    
    
    
    
}
- (IBAction)localNotify:(UIButton *)sender {
    
    //0、获取授权
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeNone categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    
    //1、创建本地通知
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    //2、设置属性
    //设置触发时间
    noti.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
    //设置横幅内容
    noti.alertBody = @"你好";
    noti.alertTitle = @"中国";
    noti.alertAction = @"北京";
    //设置其他信息
    noti.userInfo = @{@"content":@"欢迎回来",@"type":@2};
    
    //预定通知时间
    [[UIApplication sharedApplication] scheduleLocalNotification:noti];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   //监听普通通知
     [[NSNotificationCenter defaultCenter] postNotificationName:@"name" object:nil];
    
    
    
}
//监听通知方法
-(void)notifi{
    NSLog(@"----");
}


-(void)dealloc{
    [self removeObserver:self forKeyPath:@"name"];
    
}

@end
