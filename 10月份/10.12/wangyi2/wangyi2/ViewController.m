//
//  ViewController.m
//  wangyi2
//
//  Created by codygao on 16/10/13.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weibo://"]]){
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weibo://WANG" ]];
        
    }
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
