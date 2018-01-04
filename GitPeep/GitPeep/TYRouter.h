//
//  TYRouter.h
//  GitPeep
//
//  Created by tiany on 2018/1/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TYViewController;
@class TYViewModel;

@interface TYRouter : NSObject

/// Retrieves the shared router instance.
+ (instancetype)sharedInstance;

/// Retrieves the view corresponding to the given view model.
- (TYViewController *)viewControllerForViewModel:(TYViewModel *)viewModel;

@end
