//
//  CarsModel.h
//  CarsListOC
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeatailCars.h"
@interface CarsModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSArray<DeatailCars*> *cars;


@end
