//
//  AppCarsGroup.m
//  CarsGroup
//
//  Created by codygao on 16/10/15.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "AppCarsGroup.h"

@implementation AppCarsGroup
-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
