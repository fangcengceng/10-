//
//  HMappView.m
//  oc天天酷跑
//
//  Created by codygao on 16/10/10.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "HMappView.h"
#import "Hmapps.h"
@interface HMappView()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation HMappView
+(instancetype)appView{
    return [[UINib nibWithNibName:@"HMappView" bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
}

-(void)setAppmodel:(Hmapps *)appmodel{
    _appmodel = appmodel;
    self.iconImgView.image = [UIImage imageNamed:appmodel.icon];
    self.nameLabel.text = appmodel.name;
}

@end
