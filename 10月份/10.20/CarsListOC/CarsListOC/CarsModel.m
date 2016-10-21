//
//  CarsModel.m
//  CarsListOC
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "CarsModel.h"

@implementation CarsModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"cars" : [DeatailCars class] };
}

@end
