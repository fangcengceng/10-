//
//  HMAppView.h
//  代理和block的回顾
//
//  Created by codygao on 16/10/14.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMApp;

typedef void(^MyBlock)(HMApp* app, UIButton *button);
@interface HMAppView : UIView
//模型属性
@property(nonatomic,strong)HMApp *app;
@property(nonatomic,copy)MyBlock myblock;

+(instancetype)appView;
@end
