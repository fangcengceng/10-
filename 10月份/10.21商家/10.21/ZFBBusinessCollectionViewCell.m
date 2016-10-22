//
//  ZFBBusinessCollectionViewCell.m
//  10.21
//
//  Created by codygao on 16/10/22.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ZFBBusinessCollectionViewCell.h"
#import "Masonry.h"
#import "BusinessModel.h"

@interface ZFBBusinessCollectionViewCell ()

@property(nonatomic,weak)UIImageView *imgV;
@property(nonatomic,weak)UIButton *nameButton;
@end

@implementation ZFBBusinessCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]){
        [self setupUI];
    }
    return  self;
}
-(void)setupUI{
   
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.image = [UIImage imageNamed:@"film"];
    [self.contentView addSubview:imgV];
    self.imgV = imgV;

    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"物流" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:button];
    self.nameButton = button;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.top.equalTo(imgV.mas_bottom);
    }];
}




-(void)setBusinessModel:(BusinessModel *)businessModel{
    _businessModel = businessModel;
    self.imgV.image = [UIImage imageNamed:businessModel.icon];
    [self.nameButton setTitle:businessModel.name forState:UIControlStateNormal];
    
}


-(void)setHighlighted:(BOOL)highlighted{
    self.backgroundColor = highlighted ?[UIColor colorWithWhite:0.5 alpha:1] : [UIColor whiteColor];
}
@end
