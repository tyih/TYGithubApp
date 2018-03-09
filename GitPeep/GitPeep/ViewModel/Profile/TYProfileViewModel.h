//
//  TYProfileViewModel.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/31.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYTableViewModel.h"

#import "TYUserDetailModel.h"

@interface TYProfileViewModel : TYTableViewModel

@property (nonatomic, strong) TYUserDetailModel *userModel;

@end
