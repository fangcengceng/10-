//
//  BusinessModel.m
//  支付宝口碑
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "BusinessModel.h"

@implementation BusinessModel
-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}

@end
