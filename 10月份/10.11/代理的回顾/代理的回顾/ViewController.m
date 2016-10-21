//
//  ViewController.m
//  代理的回顾
//
//  Created by codygao on 16/10/11.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "CZView.h"

@interface ViewController ()<CZViewDelegate>
@property(nonatomic,weak)UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
    self.label = label;
    
    CZView *view = [[CZView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.center = self.view.center;
    [self.view addSubview:view];
    view.delegate = self;


}

-(void)clickButtonAction{
    
    self.label.text = @"djfsdjfoeiwfjr'oweiufor;weifjhrowiefjdoif;oIEFRO;WERYO;WEFROFJLSKD";
    [self.label sizeToFit];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
