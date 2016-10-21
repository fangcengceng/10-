//
//  ZFBTableViewCell.m
//  支付宝口碑
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ZFBTableViewCell.h"
#import "Masonry.h"

@interface ZFBTableViewCell ()
@property(nonatomic,weak)UIImageView *imgV;

@end


@implementation ZFBTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupUI];
    }
    return  self;
}

-(void)setupUI{
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    img.image = [UIImage imageNamed:@"kfc"];
    [self.contentView addSubview:img];
    self.imgV = img;
    
}

-(void)setBusinessmodel:(BusinessModel *)businessmodel{
    _businessmodel = businessmodel;
    self.imgV.image = [UIImage imageNamed:businessmodel.icon];
}

@end
