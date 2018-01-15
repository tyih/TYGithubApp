//
//  AppDelegate.m
//  GitPeep
//
//  Created by IGEN-TECH on 2017/12/28.
//  Copyright © 2017年 tianyao. All rights reserved.
//

#import "AppDelegate.h"

#import "TYNavigationControllerStack.h"
#import "TYViewModelServicesImpl.h"
#import "TYMainViewModel.h"
#import "TYNewFeatureViewModel.h"
#import "TYBootLoginViewModel.h"
#import "TYAccountLoginViewModel.h"
#import "TYHomePageViewModel.h"

#import <SAMKeychain.h>

@interface AppDelegate ()

@property (nonatomic, strong, readwrite) TYNavigationControllerStack *navigationControllerStack;

@property (nonatomic, strong, readwrite) TYViewModelServicesImpl *services;

@end

@implementation AppDelegate

+ (AppDelegate *)sharedDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.services = [[TYViewModelServicesImpl alloc] init];
    self.navigationControllerStack = [[TYNavigationControllerStack alloc] initWithServices:self.services];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.services resetRootViewModel:[[TYMainViewModel alloc] initWithServices:self.services params:nil]];

    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - private

- (TYViewModel *)createInitialViewModel {
    
    // 应用版本号
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:TYApplicationVersionKey];
    
    if (![version isEqualToString:APP_VERSION()]) {
        // 版本不一样，显示新特性界面
        return [[TYNewFeatureViewModel alloc] initWithServices:self.services params:nil];
    } else {
        
        if (0) {
            // 有账号，有用户数据，跳到主页
            return [[TYHomePageViewModel alloc] initWithServices:self.services params:nil];
        } else if (0) {
            // 没有账号，有用户数据，跳到登录界面
            return [[TYAccountLoginViewModel alloc] initWithServices:self.services params:nil];
        } else {
            // 第一次使用
            return [[TYBootLoginViewModel alloc] initWithServices:self.services params:nil];
        }
    }
    
}


@end
