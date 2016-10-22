//
//  BusinessModel.m
//  10.21
//
//  Created by codygao on 16/10/21.
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
