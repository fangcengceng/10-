//
//  Person+CoreDataProperties.h
//  coredata2
//
//  Created by codygao on 16/10/19.
//  Copyright © 2016年 HM. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t age;

@end

NS_ASSUME_NONNULL_END
