//
//  AppDelegate.m
//  自定义本地通知
//
//  Created by codygao on 16/10/14.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


//当应用是关闭状态是，通过通知来打开应用时，需要从该方法中获取通知内容
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 从启动选项总获取本地通知
//    NSLog(@"%@",launchOptions);
    UILocalNotification *locaNoti = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    
    [self showLocalNoti:locaNoti];

    return YES;
}
//使用自定义类型的通知时，使用该方法，可以获取通知


- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler{
    
    if ([identifier isEqualToString:@"localforeground"]) {
        NSLog(@"点击前台按钮");
        
    } else {
        
        NSLog(@"点击后台按钮");
        
    }
    //手动调用完成回调
    completionHandler();
}
//已经接收到本地通知后调用，（应用在后台时，点击通知才会调用，应用在前台时，直接调用该方法接受通知);
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSString *content = notification.userInfo[@"content"];
        NSString *indext = notification.userInfo[@"indext"];
    NSLog(@"%@---%@",content,indext);
    [self showLocalNoti:notification];
    
    
    
    
}


-(void)showLocalNoti:(UILocalNotification*)noti{
    //根据传递数据，跳转到不同的控制器
    UITabBarController *tabBar = (UITabBarController*)self.window.rootViewController;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
   
    
         [self.window.rootViewController.view addSubview:label];
 
    
    label.text = noti.userInfo[@"content"];
    
    
    NSInteger index = [noti.userInfo[@"indext"] integerValue];
    
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive){
        //应用不在前台时进行界面跳转
        
        switch (index) {
          
            case 1:
                tabBar.selectedIndex = 1;
                break;
            case 2:
                tabBar.selectedIndex = 2;
                break;
            default:
                break;
        }
    }else{
        NSLog(@"接收到索引：%ld",index);
    }
    
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
