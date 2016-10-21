//
//  User+CoreDataProperties.h
//  版本兼容
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User*> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *usename;
@property (nonatomic) int32_t age;

@end

NS_ASSUME_NONNULL_END
