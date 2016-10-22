//
//  HMCoreDataManager.h
//  02-CoreData框架探索
//
//  Created by 刘凡 on 2016/9/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/**
 CoreData管理器
 */
@interface HMCoreDataManager : NSObject

+ (instancetype)sharedManager;

/**
 持久化容器 - 可以提供管理上下文 iOS 10 推出
 包含了 Core Data stack 中所有的核心对象，都不是线程安全的
 
 - NSManagedObjectContext *viewContext; 管理上下文
 - NSManagedObjectModel *managedObjectModel;
 - NSPersistentStoreCoordinator *persistentStoreCoordinator;
 */
//@property (readonly, strong) NSPersistentContainer *persistentContainer;

/**
 管理对象上下文
 */
@property (readonly, strong) NSManagedObjectContext *moc;

/**
 保存上下文
 */
- (void)saveContext;

@end
