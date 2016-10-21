//
//  BusinessModel.h
//  支付宝口碑
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessModel : NSObject
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString* discount;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSNumber *averagePrice;
@property(nonatomic,strong)NSNumber *distance;
@property(nonatomic,strong)NSNumber *offNum;
@property(nonatomic,strong)NSNumber *level;


-(instancetype)initWithDic:(NSDictionary*)dic;

@end
