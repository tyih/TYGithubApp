//
//  TYMainViewModel.h
//  GitPeep
//
//  Created by tiany on 2018/1/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYViewModel.h"

//#import "TYNewsViewModel.h"
#import "TYUsersViewModel.h"
#import "TYRepositoriesViewModel.h"
#import "TYExploreViewModel.h"
#import "TYProfileViewModel.h"

@interface TYMainViewModel : TYViewModel

//@property (nonatomic, strong, readonly) TYNewsViewModel *newsViewModel;
@property (nonatomic, strong, readonly) TYUsersViewModel *usersViewModel;

@property (nonatomic, strong, readonly) TYRepositoriesViewModel *reposViewModel;

@property (nonatomic, strong, readonly) TYExploreViewModel *exploreViewModel;

@property (nonatomic, strong, readonly) TYProfileViewModel *profileViewModel;

@end
