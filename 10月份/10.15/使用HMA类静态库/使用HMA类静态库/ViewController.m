//
//  ViewController.m
//  使用HMA类静态库
//
//  Created by codygao on 16/10/15.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "imgTool.h"
#import "HMLibrary.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  int sum =  [HMLibrary sumA:2 andB:3];
    NSLog(@"%d",sum);
    imgTool *imgtoll = [[imgTool alloc] init];
    UIImageView *img = [[UIImageView alloc] initWithImage:[imgtoll createImg]];
    [img sizeToFit];
    [self.view addSubview:img];



}



@end
