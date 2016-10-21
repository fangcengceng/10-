//
//  AppCarsGroup.h
//  CarsGroup
//
//  Created by codygao on 16/10/15.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppCarsGroup : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,strong)NSArray *cars;
-(instancetype)initWithDic:(NSDictionary*)dic;

@end
