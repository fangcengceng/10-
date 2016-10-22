//
//  City+CoreDataProperties.h
//  coredata多表联动
//
//  Created by codygao on 16/10/21.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "City+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface City (CoreDataProperties)

+ (NSFetchRequest<City *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *cityName;
@property (nullable, nonatomic, retain) NSSet<User *> *users;

@end

@interface City (CoreDataGeneratedAccessors)

- (void)addUsersObject:(User *)value;
- (void)removeUsersObject:(User *)value;
- (void)addUsers:(NSSet<User *> *)values;
- (void)removeUsers:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
