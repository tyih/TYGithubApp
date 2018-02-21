//
//  TYViewModelServicesImpl.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/3.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYViewModelServicesImpl.h"

@implementation TYViewModelServicesImpl

@synthesize client = _client; // 自动生成getter、setter方法

- (void)pushViewModel:(TYViewModel *)viewModel animated:(BOOL)animated {}

- (void)popViewModelAnimated:(BOOL)animated {}

- (void)popToRootViewModelAnimated:(BOOL)animated {}

- (void)presentViewModel:(TYViewModel *)viewModel animated:(BOOL)animated completion:(voidBlock)completion {}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(voidBlock)completion {}

- (void)resetRootViewModel:(TYViewModel *)viewModel {}

@end
