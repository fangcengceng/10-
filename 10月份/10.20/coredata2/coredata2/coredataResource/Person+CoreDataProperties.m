//
//  Person+CoreDataProperties.m
//  coredata2
//
//  Created by codygao on 16/10/19.
//  Copyright © 2016年 HM. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic name;
@dynamic age;

@end
