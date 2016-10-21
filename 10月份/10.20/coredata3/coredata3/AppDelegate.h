//
//  AppDelegate.h
//  coredata3
//
//  Created by codygao on 16/10/19.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//数据持久化容器
@property (readonly, strong) NSPersistentContainer *persistentContainer;
//保存数据
- (void)saveContext;


@end

