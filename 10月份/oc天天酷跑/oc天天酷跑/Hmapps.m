//
//  Hmapps.m
//  oc天天酷跑
//
//  Created by codygao on 16/10/10.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "Hmapps.h"

@implementation Hmapps

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self =[super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}
+(instancetype)appWithDic:(NSDictionary*)dic{
    return  [[self alloc] initWithDic:dic];
}
@end
