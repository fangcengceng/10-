//
//  AppDelegate.m
//  本地通知1
//
//  Created by codygao on 16/10/14.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//当应用是关闭状态是，通过通知来打开应用时，需要从该方法中获取通知的内容

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //从启动选项中获取本地通知
    UILocalNotification *localNote = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    [self showLocalNoti:localNote];
    return YES;
}
//已经接收到本地通知后调用（应用在后台是，点击通知后才会调用；应用在前台时，直接调用该方法接受通知）
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSString *content = notification.userInfo[@"content"];
    [self showLocalNoti:notification ];
    
    
    
}
-(void)showLocalNoti:(UILocalNotification*)localNote{
    //使用UI展示获取通知内容
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,100, 100)];
    [self.window.rootViewController.view addSubview:label];
    label.backgroundColor = [UIColor redColor];
   label.text = localNote.userInfo[@"content"];
    
    //根据传递数据，跳转到不同的控制器
    NSInteger type = [localNote.userInfo[@"type"] integerValue];
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive){
        //当应用不在前台时进行界面跳转
        UITabBarController *tabBarVC = (UITabBarController*)self.window.rootViewController;
        
        switch (type) {
            case 0:
                tabBarVC.selectedIndex = 0;
                break;
            case 1:
                tabBarVC.selectedIndex = 1;
                break;
            case 2:
                tabBarVC.selectedIndex = 2;
                break;
                
            default:
                break;
        }
        
    }else{
        NSLog(@"接受到索引:%zd",type);
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
