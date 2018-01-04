//
//  TYViewController.h
//  GitPeep
//
//  Created by tiany on 2018/1/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TYViewModel;

@interface TYViewController : UIViewController

@property (nonatomic, strong, readwrite) UIView *snapshot;

@property (nonatomic, strong, readonly) TYViewModel *viewModel;

/// Initialization method. This is the preferred way to create a new view.
- (instancetype)initWithViewModel:(TYViewModel *)viewModel;

/// Binds the corresponding view model to the view.
- (void)bindViewModel;

@end
