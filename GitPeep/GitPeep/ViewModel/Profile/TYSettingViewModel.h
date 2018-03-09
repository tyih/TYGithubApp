//
//  TYSettingViewModel.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/9.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYViewModel.h"

@interface TYSettingViewModel : TYViewModel

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) RACCommand *didSelectCommand;

@end
