//
//  City+CoreDataProperties.h
//  版本兼容
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "City+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface City (CoreDataProperties)

+ (NSFetchRequest<City *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *cityname;

@end

NS_ASSUME_NONNULL_END
