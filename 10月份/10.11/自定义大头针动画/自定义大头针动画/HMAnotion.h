//
//  HMAnotion.h
//  自定义大头针动画
//
//  Created by codygao on 16/10/11.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface HMAnotion : NSObject<MKAnnotation>
//协议属性
@property (nonatomic) CLLocationCoordinate2D coordinate;

//自定义大头针视图的标题
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subtitle;



@end
