//
//  TYMacros.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/3.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#ifndef TYMacros_h
#define TYMacros_h

/// 存储应用版本号
#define TYApplicationVersionKey @"TYApplicationVersionKey"

/// 应用版本号
#define APP_VERSION() \
[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

/// 应用名称
#define APP_NAME() \
[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]

#pragma mark -

/// 打印格式
#ifdef DEBUG

#define NSLog(format, ...) \
printf("\n[%s] %s line:%zd 🌶 %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);

#else

#define NSLog(format, ...)

#endif

#pragma mark -

/// 设备类型
#define IS_IPAD     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/// 屏幕尺寸
#define SCREEN_WIDTH     ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT    ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_BOUNDS    ([[UIScreen mainScreen] bounds])
#define SCREEN_MAX_LENGTH    (MAX(TY_SCREEN_WIDTH, TY_SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH    (MIN(TY_SCREEN_WIDTH, TY_SCREEN_HEIGHT))

/// 手机类型
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5         (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6         (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P        (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X         (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

#pragma mark -

/// 顶部状态栏高度
#define STATUS_BAR_HEIGHT   ([[UIApplication sharedApplication] statusBarFrame].size.height)

/// 导航栏高度
#define NAV_BAR_HEIGHT      (self.navigationController.navigationBar.frame.size.height)

/// 状态栏+导航栏
#define TOP_BAR_HEIGHT      (([XDeviceHelper systemVersion] >= 7) ? (NAV_BAR_HEIGHT + STATUS_BAR_HEIGHT) : NAV_BAR_HEIGHT)

/// 底部tab栏高度
#define TAB_BAR_HEIGHT      (self.tabBarController.tabBar.frame.size.height)

#pragma mark -

/// 系统版本
#define IOS_VERSION     ([[[UIDevice currentDevice] systemVersion] floatValue])

#define IOS_VERSION_7_OR_LATTER     ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
#define IOS_VERSION_8_OR_LATTER     ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
#define IOS_VERSION_9_OR_LATTER     ([UIDevice currentDevice].systemVersion.floatValue >= 9.0)
#define IOS_VERSION_10_OR_LATTER    ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)

#pragma mark -

#define RGB(r, g, b) \
[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define RGBAlpha(r, g, b, a) \
[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define HexRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define HexRGBAlpha(rgbValue, a) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define colorA1 0x2F434F
#define colorA2 0x4183C4
#define colorA3 0xF7F7F7

#pragma mark -

/// AppDelegate
#define TYSharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#pragma mark -

/// SAMKeychain
#define GH_SERVICE_NAME @"com.tianyao.GitPeep"
#define GH_RAW_LOGIN    @"RawLogin"
#define GH_PASSWORD     @"Password"
#define GH_ACCESS_TOKEN @"AccessToken"

#endif /* TYMacros_h */
