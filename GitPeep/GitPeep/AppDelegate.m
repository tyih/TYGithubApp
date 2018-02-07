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
#import "TYLoginViewModel.h"
#import "TYNewsViewModel.h"

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
    
    /// Congigure Before Init UI
    [self configureApplication:application initialParamsBeforeInitUI:launchOptions];
    
    // Configure Service
    self.services = [[TYViewModelServicesImpl alloc] init];
    // Configure Navigation Stack
    self.navigationControllerStack = [[TYNavigationControllerStack alloc] initWithServices:self.services];
    // Configure Window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // Reset Root Controller
    [self.services resetRootViewModel:[self createInitialViewModel]];
    // Window Visible
    [self.window makeKeyAndVisible];
    
    /// Congigure After Init UI
    [self configureApplication:application initialParamsAfterInitUI:launchOptions];
    
    /// Save Application Version Last
    [[NSUserDefaults standardUserDefaults] setObject:APP_VERSION() forKey:TYApplicationVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
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
        
        if ([SAMKeychain rawLogin].isExist && [SAMKeychain accessToken].isExist) {

            // 有账号，有用户数据，跳到主页
            return [[TYMainViewModel alloc] initWithServices:self.services params:nil];
        } else if (1) {
            // 没有账号，有用户数据，跳到登录界面
            return [[TYLoginViewModel alloc] initWithServices:self.services params:nil];
        }
    }
}

#pragma mark - Configure Before Init UI

- (void)configureApplication:(UIApplication *)application initialParamsBeforeInitUI:(NSDictionary *)launchOptions {
    
    /// 显示状态栏
    
    /// 配置键盘
    [self configureKeyboardManager];
    
    /// 配置文件夹
    
    /// 配置数据库
}

#pragma mark - Configure After Init UI

- (void)configureApplication:(UIApplication *)application initialParamsAfterInitUI:(NSDictionary *)launchOptions {
    
    /// 配置样式
    [self configureAppearance];
    
    /// 配置弹出框
    
    /// 配置平台信息
    
    /// 监听通知
    
    /// 配置H5
}
#pragma mark - Configure

- (void)configureAppearance {
    
    [UINavigationBar appearance].barTintColor = HexRGB(colorA1);
    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    [UISegmentedControl appearance].tintColor = [UIColor whiteColor];
    
    [UITabBar appearance].tintColor = HexRGB(colorA2);
}

- (void)configureKeyboardManager {
    
    IQKeyboardManager.sharedManager.enableAutoToolbar = NO;
    IQKeyboardManager.sharedManager.shouldResignOnTouchOutside = YES;
}

@end
