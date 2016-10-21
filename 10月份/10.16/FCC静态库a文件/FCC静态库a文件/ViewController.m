//
//  ViewController.m
//  FCC静态库a文件
//
//  Created by codygao on 16/10/17.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "HMLibrary1.h"
#import "ImgTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int sum = [HMLibrary1 sumA:1 andB:2];
    NSLog(@"%d",sum);
    
    UIImageView *imgv = [[UIImageView alloc] initWithImage:[ImgTool createImag]];
    [self.view addSubview:imgv];
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
