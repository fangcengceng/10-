//
//  User+CoreDataProperties.m
//  版本兼容
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic usename;
@dynamic age;

@end
