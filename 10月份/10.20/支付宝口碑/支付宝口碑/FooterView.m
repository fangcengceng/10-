//
//  FooterView.m
//  支付宝口碑
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//



#import "FooterView.h"
#import "Masonry.h"
@interface FooterView()
@end
@implementation FooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return  self;
}
-(void)setupUI{
    
    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"加载更多" forState:UIControlStateNormal];
    [self addSubview:button];
    [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(40);
    }];

    
}

-(void)clickAction:(UIButton*)sender{
    if (_myBlock != nil){
        _myBlock();
    }

}


@end
