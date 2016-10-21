//
//  City+CoreDataProperties.m
//  coredata版本兼容最终版
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
