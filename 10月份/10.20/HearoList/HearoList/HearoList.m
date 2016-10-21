//
//  HearoList.m
//  HearoList
//
//  Created by codygao on 16/10/19.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "HearoList.h"

@implementation HearoList
-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
