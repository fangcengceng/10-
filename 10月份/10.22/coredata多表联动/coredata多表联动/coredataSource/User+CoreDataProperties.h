//
//  User+CoreDataProperties.h
//  coredata多表联动
//
//  Created by codygao on 16/10/21.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *username;
@property (nonatomic) int32_t height;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nullable, nonatomic, retain) City *city;

@end

NS_ASSUME_NONNULL_END
