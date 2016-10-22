//
//  FCCPicture.h
//  图片浏览器
//
//  Created by codygao on 16/10/9.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCCPicture : NSObject

//图片
@property(nonatomic,copy)NSString *icon;
//描述标签
@property(nonatomic,copy)NSString *desc;
//索引标签
@property(nonatomic,copy)NSString* count;

-(instancetype)initWithDic:(NSDictionary*)dic;

+(instancetype)pictureWithDic:(NSDictionary*)dic;

@end
