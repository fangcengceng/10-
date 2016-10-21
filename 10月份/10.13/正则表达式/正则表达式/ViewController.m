//
//  ViewController.m
//  正则表达式
//
//  Created by codygao on 16/10/13.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)click:(UIButton *)bu{
    //ios9以后要求授权
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert| UIUserNotificationTypeNone| UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    localNote.userInfo = @{@"text":@"sdkjflsd"};
    localNote.alertBody = @"八戒，你接到一条提醒";
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //匹配的内容
    NSString *pattenrn = @"[a-zA-Z][0-9]";
    //被匹配的文字段
    NSString *text = @"adjf;afj'lafj'ewpoaifr2";
    NSRegularExpression *experrion = [NSRegularExpression regularExpressionWithPattern:pattenrn options:0 error:nil] ;
    NSArray *results = [experrion matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    NSLog(@"%zd",results.count);
    
    //创建本地通知
    
    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeContactAdd];
    bu.center = self.view.center;
    [bu sizeToFit];
    [self.view addSubview:bu];
    [bu addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
