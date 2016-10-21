//
//  HMAppView.m
//  代理和block的回顾
//
//  Created by codygao on 16/10/14.
//  Copyright © 2016年 HM. All rights reserved.
//



#import "HMAppView.h"
#import "HMApp.h"

@interface HMAppView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;


@end
@implementation HMAppView
//初始化HMAppView
+(instancetype)appView{
    
    
    return  [[UINib nibWithNibName:@"HMAppView" bundle:nil] instantiateWithOwner:nil options:nil].lastObject;
}

-(void)setApp:(HMApp *)app{
    _app = app;
    self.iconImg.image = [UIImage imageNamed:app.icon];
    
    
}

- (IBAction)clickButton:(UIButton *)sender {
    _myblock(self.app,sender);
    
    
    
    
}




@end
