//
//  HMApp.h
//  代理和block的回顾
//
//  Created by codygao on 16/10/14.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMApp : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *icon;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
