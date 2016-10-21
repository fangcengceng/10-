//
//  ViewController.m
//  HM静态库
//
//  Created by codygao on 16/10/16.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "ImgTool.h"
#import "HMLibrary1.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    int sum = [HMLibrary1 sumA:2 andB:3];
    NSLog(@"%d",sum);
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[ImgTool createImag]];
    [self.view addSubview:image];
    UIImageView *image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mao"]];
    image1.center = self.view.center;
    [self.view addSubview:image1];
    
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
