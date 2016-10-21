//
//  CZView.m
//  代理的回顾
//
//  Created by codygao on 16/10/11.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "CZView.h"

@implementation CZView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =  [super initWithFrame:frame]){
        [self setupUI];
    }
    return  self;
    
}


-(void)setupUI{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.center = self.center;
    
    [self addSubview:button];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)click:(UIButton*)button{
        [self.delegate clickButtonAction];
    
    
}

@end
