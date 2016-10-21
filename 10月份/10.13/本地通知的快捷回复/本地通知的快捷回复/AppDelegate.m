//
//  AppDelegate.m
//  本地通知的快捷回复
//
//  Created by codygao on 16/10/14.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    UILocalNotification *localNoti = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    [self showLocalNoti:localNoti];
    
    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    [self showLocalNoti:notification];
    
    NSLog(@"%@",notification.userInfo[@"content"]);
    
    
}
//使用自定义类型的通知，可以区分不同的按钮

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
    
    if ([identifier isEqualToString:@"foregroud"]){
        NSLog(@"点击前台按钮");
    }else{
        NSLog(@"点击后台按钮");
    }
    completionHandler();

    
}



//快捷回复的代理
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)())completionHandler{
    
    NSString *responsContact = responseInfo[UIUserNotificationActionResponseTypedTextKey];
    NSLog(@"%@",responsContact);
    completionHandler();
    
    
}


-(void)showLocalNoti:(UILocalNotification*)noti{
    
    //根据传递数据不同跳转到不同的控制器；
    
    NSInteger type = [noti.userInfo[@"type"] integerValue];
    
    UITabBarController *tabBar = (UITabBarController*)self.window.rootViewController;
    
    //当应用不在前台的时候进行跳转
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive){
          switch (type) {
              case 0:
                  tabBar.selectedIndex = 0;
                  break;
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
        NSLog(@"%zd",tabBar.selectedIndex);
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
