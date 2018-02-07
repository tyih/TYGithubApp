//
//  TYNavigationControllerStack.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/3.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYNavigationControllerStack.h"

#import "TYNavigationController.h"
#import "TYViewModelServices.h"
#import "TYViewController.h"
#import "TYRouter.h"

@interface TYNavigationControllerStack ()

@property (nonatomic, strong) id<TYViewModelServices> services;

@property (nonatomic, strong) NSMutableArray *navigationControllers;

@end

@implementation TYNavigationControllerStack

- (instancetype)initWithServices:(id<TYViewModelServices>)services {
    
    self = [super init];
    if (self) {
        self.services = services;
        self.navigationControllers = [NSMutableArray array];
        [self registerNavigationHooks];
    }
    return self;
}

- (void)pushNavigationController:(UINavigationController *)navigationController {
    
    if ([self.navigationControllers containsObject:navigationController]) {
        
        return;
    }
    [self.navigationControllers addObject:navigationController];
}

- (UINavigationController *)popNavigationController {
    
    UINavigationController *navCtrl = self.navigationControllers.lastObject;
    [self.navigationControllers removeLastObject];
    return navCtrl;
}

- (UINavigationController *)topNavigationController {
    
    return self.navigationControllers.lastObject;
}

#pragma mark - private

- (void)registerNavigationHooks {
    
    @weakify(self);
    
    // pushViewModel
    [[(NSObject *)self.services rac_signalForSelector:@selector(pushViewModel:animated:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        // 取出顶部navCtrl
        TYViewController *topViewController = (TYViewController *)[self.navigationControllers.lastObject topViewController];
        // 判断是否是tabBarCtrl
        if (topViewController.tabBarController) {
            topViewController.snapshot = [topViewController.tabBarController.view snapshotViewAfterScreenUpdates:NO];
        } else {
            topViewController.snapshot = [[self.navigationControllers.lastObject view] snapshotViewAfterScreenUpdates:NO];
        }
        TYViewController *viewController = [[TYRouter sharedInstance] viewControllerForViewModel:x.first];
        [self.navigationControllers.lastObject pushViewController:viewController animated:[x.second boolValue]];
    }];
    
    // popViewModelAnimated
    [[(NSObject *)self.services rac_signalForSelector:@selector(popViewModelAnimated:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        
        [self.navigationControllers.lastObject popViewControllerAnimated:[x.first boolValue]];
    }];
    
    // popToRootViewModelAnimated
    [[(NSObject *)self.services rac_signalForSelector:@selector(popToRootViewModelAnimated:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        
        [self.navigationControllers.lastObject popToRootViewControllerAnimated:[x.first boolValue]];
    }];
    
    // presentViewModel
    [[(NSObject *)self.services rac_signalForSelector:@selector(presentViewModel:animated:completion:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        
        UIViewController *viewController = [[TYRouter sharedInstance] viewControllerForViewModel:x.first];
        UINavigationController *presentingViewController = self.navigationControllers.lastObject;
        if (![viewController isKindOfClass:UINavigationController.class]) {
            viewController = [[TYNavigationController alloc] initWithRootViewController:viewController];
        }
        [self pushNavigationController:(UINavigationController *)viewController];
        [presentingViewController presentViewController:viewController animated:[x.second boolValue] completion:x.third];
    }];
    
    // dismissViewModelAnimated
    [[(NSObject *)self.services rac_signalForSelector:@selector(dismissViewModelAnimated:completion:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        
        [self popNavigationController];
        [self.navigationControllers.lastObject dismissViewControllerAnimated:[x.first boolValue] completion:x.second];
    }];
    
    // resetRootViewModel
    [[(NSObject *)self.services rac_signalForSelector:@selector(resetRootViewModel:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        
        [self.navigationControllers removeAllObjects];
        UIViewController *viewController = [TYRouter.sharedInstance viewControllerForViewModel:x.first];
        if (![viewController isKindOfClass:[UINavigationController class]] && ![viewController isKindOfClass:[UITabBarController class]]) {
            viewController = [[TYNavigationController alloc] initWithRootViewController:viewController];
            [self pushNavigationController:(UINavigationController *)viewController];
        }
        TYSharedAppDelegate.window.rootViewController = viewController;
    }];
}

@end
