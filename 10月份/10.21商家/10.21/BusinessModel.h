//
//  BusinessModel.h
//  10.21
//
//  Created by codygao on 16/10/21.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *icon;

//dic

-(instancetype)initWithDic:(NSDictionary*)dic;


@end
