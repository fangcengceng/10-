//
//  ViewController.m
//  wangyi
//
//  Created by codygao on 16/10/13.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//as100,app.91.com，
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    
    
    



}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weibo://"]]){
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weibo://wangyi"]];
    }else {
        NSLog(@"请到app商店下载");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
