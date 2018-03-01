//
//  TYUserDetailViewModel.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/1.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYTableViewModel.h"

#import "TYUserDetailModel.h"

@interface TYUserDetailViewModel : TYTableViewModel

// userDetail请求
@property (nonatomic, strong, readonly) RACCommand *requestUserDetailCommand;

@end
