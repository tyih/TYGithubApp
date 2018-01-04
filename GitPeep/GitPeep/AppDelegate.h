//
//  AppDelegate.h
//  GitPeep
//
//  Created by IGEN-TECH on 2017/12/28.
//  Copyright © 2017年 tianyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TYNavigationControllerStack;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/// 导航栏堆栈
@property (nonatomic, strong, readonly) TYNavigationControllerStack *navigationControllerStack;

// AppDelegate
+ (AppDelegate *)sharedDelegate;

@end

