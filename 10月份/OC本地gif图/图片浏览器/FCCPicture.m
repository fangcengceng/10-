//
//  FCCPicture.m
//  图片浏览器
//
//  Created by codygao on 16/10/9.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "FCCPicture.h"

@implementation FCCPicture

-(instancetype)initWithDic:(NSDictionary*)dic{
    
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}


+(instancetype)pictureWithDic:(NSDictionary*)dic{
    
    return [[self alloc] initWithDic:dic];
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
