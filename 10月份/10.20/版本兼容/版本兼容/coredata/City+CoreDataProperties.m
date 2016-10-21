//
//  City+CoreDataProperties.m
//  版本兼容
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "City+CoreDataProperties.h"

@implementation City (CoreDataProperties)

+ (NSFetchRequest<City *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"City"];
}

@dynamic cityname;

@end
