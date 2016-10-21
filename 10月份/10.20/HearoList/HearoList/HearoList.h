//
//  HearoList.h
//  HearoList
//
//  Created by codygao on 16/10/19.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HearoList : NSObject
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *intro;
-(instancetype)initWithDic:(NSDictionary*)dic;

@end
