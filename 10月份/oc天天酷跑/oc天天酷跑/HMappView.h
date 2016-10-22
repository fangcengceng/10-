//
//  HMappView.h
//  oc天天酷跑
//
//  Created by codygao on 16/10/10.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Hmapps;
@interface HMappView : UIView

@property(nonatomic,strong)Hmapps *appmodel;
+(instancetype)appView;


@end
