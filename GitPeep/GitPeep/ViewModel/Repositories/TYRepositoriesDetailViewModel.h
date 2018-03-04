//
//  TYRepositoriesDetailViewModel.h
//  GitPeep
//
//  Created by tiany on 2018/3/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYTableViewModel.h"

@interface TYRepositoriesDetailViewModel : TYTableViewModel

@property (nonatomic, assign) TYTabButtonsType chooseType;

// reposDetail请求
@property (nonatomic, strong, readonly) RACCommand *requestReposDetailCommand;

@end
