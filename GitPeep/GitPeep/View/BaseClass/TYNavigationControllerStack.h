//
//  TYNavigationControllerStack.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/3.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TYViewModelServices;

@interface TYNavigationControllerStack : NSObject

- (instancetype)initWithServices:(id<TYViewModelServices>)services;

- (void)pushNavigationController:(UINavigationController *)navigationController;

- (UINavigationController *)popNavigationController;

- (UINavigationController *)topNavigationController;

@end
