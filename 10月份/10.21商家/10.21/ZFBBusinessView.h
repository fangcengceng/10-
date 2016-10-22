//
//  ZFBBusinessView.h
//  10.21
//
//  Created by codygao on 16/10/21.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZFBBusinessView;
@class BusinessModel;
//选中商家模型的代理
@protocol ZFBBusinessViewDelegate <NSObject>
-(void)DidselectModel:(ZFBBusinessView*)view model:(BusinessModel*)model;
@end

@interface ZFBBusinessView : UIView
//点击按钮处理进入到具体的详情的代理方法
@property(nonatomic,weak)id <ZFBBusinessViewDelegate> delegate;

//接受控制器传来的数据
@property(nonatomic,strong)NSArray *array;
@end
