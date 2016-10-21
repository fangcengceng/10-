//
//  HMAnnotion.h
//  定义大头针
//
//  Created by codygao on 16/10/11.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface HMAnnotion : NSObject<MKAnnotation>
//协议中的属性和方法
@property (nonatomic) CLLocationCoordinate2D coordinate;

//自定义大头针模型的属性
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString *subtitle;
@end
