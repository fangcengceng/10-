//
//  Hmapps.h
//  oc天天酷跑
//
//  Created by codygao on 16/10/10.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hmapps : NSObject
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *name;

-(instancetype)initWithDic:(NSDictionary*)dic;
+(instancetype)appWithDic:(NSDictionary*)dic;
@end
