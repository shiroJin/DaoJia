//
//  AppDelegate.m
//  DaoJia
//
//  Created by Macx on 16/1/27.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import "MainViewController.h"
#import "DaojiaNavigationController.h"
#import "HomeViewController.h"
#import "WodeNVController.h"
#import "WodeViewController.h"
#import "ClubViewController.h"
#import "BaseNavigationVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    MainViewController *mainViewController = [[MainViewController alloc] init];
    
    DaojiaNavigationController *daojia = [UIStoryboard storyboardWithName:@"Daojia" bundle:nil].instantiateInitialViewController;
    UIViewController *home = [[HomeViewController alloc] init];
    BaseNavigationVC *guangchang = [[BaseNavigationVC alloc] initWithRootViewController:[[ClubViewController alloc] init]];
    WodeNVController *person = [[WodeNVController alloc] initWithRootViewController:[[WodeViewController alloc] init]];
    mainViewController.viewControllers = @[
                                           daojia,
                                           home,
                                           guangchang,
                                           person,
                                           ];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"image_pre_bigView.jpg"]];
    
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = mainViewController;
    
    //分享功能
    [ShareSDK registerApp:@"f878d33a5cba"];
    [ShareSDK connectSinaWeiboWithAppKey:@"421265028" appSecret:@"3a02cddd1994a5b2981ece024bddc474" redirectUri:@"http://www.baidu.com"];
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [ShareSDK handleOpenURL:url wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
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
