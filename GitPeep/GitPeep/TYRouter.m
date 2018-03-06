//
//  TYRouter.m
//  GitPeep
//
//  Created by tiany on 2018/1/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYRouter.h"

#import "TYViewModel.h"
#import "TYViewController.h"

@interface TYRouter ()

/// viewModel->viewController
@property (nonatomic, copy) NSDictionary *viewModelViewMappings;

@end

@implementation TYRouter

static TYRouter *sharedInstance_ = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance_ = [super allocWithZone:zone];
    });
    return sharedInstance_;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    
    return sharedInstance_;
}

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance_ = [[self alloc] init];
    });
    return sharedInstance_;
}

- (TYViewController *)viewControllerForViewModel:(TYViewModel *)viewModel {
    
    // viewModel->viewController
    NSString *viewController = self.viewModelViewMappings[NSStringFromClass(viewModel.class)];
    
    // 是否是TYViewController的子类
    NSParameterAssert([NSClassFromString(viewController) isSubclassOfClass:[TYViewController class]]);
    // 是否有方法initWithViewModel:
    NSParameterAssert([NSClassFromString(viewController) instancesRespondToSelector:@selector(initWithViewModel:)]);
    
    return [[NSClassFromString(viewController) alloc] initWithViewModel:viewModel];
}

- (NSDictionary *)viewModelViewMappings {
    
    return @{
             @"TYNewFeatureViewModel" : @"TYNewFeatureController",
             @"TYOAuthViewModel" : @"TYOAuthViewController",
             @"TYLoginViewModel" : @"TYLoginController",
             @"TYMainViewModel" : @"TYMainController",
//             @"TYNewsViewModel" : @"TYNewsController"
             @"TYUsersViewModel" : @"TYUsersController",
             @"TYRepositoriesViewModel" : @"TYRepositoriesController",
             @"TYUserDetailViewModel" : @"TYUserDetailController",
             @"TYRepositoriesDetailViewModel" : @"TYRepositoriesDetailController"
             };
}

@end
