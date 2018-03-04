//
//  TYTableViewModel.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/26.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYViewModel.h"

@interface TYTableViewModel : TYViewModel

@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, assign) NSUInteger page;

/// cell点击
@property (nonatomic, strong) RACCommand *didSelectCommand;

/// 请求command
@property (nonatomic, strong, readonly) RACCommand *requestRemoteDataCommand;

/// 网络请求-子类重写
- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page;

@end
