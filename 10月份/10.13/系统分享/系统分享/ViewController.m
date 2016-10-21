//
//  ViewController.m
//  系统分享
//
//  Created by codygao on 16/10/14.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self shared];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]){
        //添加是否在设置中添加了对应的平台账号
        SLComposeViewController *comVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        //设置属性
        [comVC addImage:[UIImage imageNamed:@"zl"]];
        [comVC setInitialText:@"寻找姐妹"];
        [comVC addURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/dong-wu-lian-tu-xiang-bian/id936613170?mt=8"]];
        //显示
        [self presentViewController:comVC animated:YES completion:nil];
        
    }else{
        NSLog(@"请在设置中添加微博账号平台");
    }
    
    
}

-(void)shared{
    
    //判断是否在系统中开启了
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTencentWeibo]){
        SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTencentWeibo];
    
     
        [vc addImage:[UIImage imageNamed:@"zl"]];
        [vc setTitle:@"hhhh"];
        //显示
        [self presentViewController:vc animated:YES completion:nil];
    
    }else{
        NSLog(@"请在设置中开启");
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
