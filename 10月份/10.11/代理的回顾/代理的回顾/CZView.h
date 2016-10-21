//
//  CZView.h
//  代理的回顾
//
//  Created by codygao on 16/10/11.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CZViewDelegate

-(void)clickButtonAction;
@end

@interface CZView : UIView
@property(nonatomic,weak)id<CZViewDelegate> delegate;
@end
