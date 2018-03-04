//
//  TYMainViewModel.m
//  GitPeep
//
//  Created by tiany on 2018/1/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYMainViewModel.h"

@interface TYMainViewModel ()

//@property (nonatomic, strong, readwrite) TYNewsViewModel *newsViewModel;
@property (nonatomic, strong, readwrite) TYUsersViewModel *usersViewModel;

@property (nonatomic, strong, readwrite) TYRepositoriesViewModel *reposViewModel;

@property (nonatomic, strong, readwrite) TYExploreViewModel *exploreViewModel;

@property (nonatomic, strong, readwrite) TYProfileViewModel *profileViewModel;

@end


@implementation TYMainViewModel

- (void)initialize {
    
    [super initialize];
    
//    self.newsViewModel = [[TYNewsViewModel alloc] initWithServices:self.services params:@{@"title" : @"News"}];
    self.usersViewModel = [[TYUsersViewModel alloc] initWithServices:self.services params:@{@"title" : @"Users"}];
    
    self.reposViewModel = [[TYRepositoriesViewModel alloc] initWithServices:self.services params:@{@"title" : @"Repositories"}];
    
    self.exploreViewModel = [[TYExploreViewModel alloc] initWithServices:self.services params:@{@"title" : @"Explore"}];
    
    self.profileViewModel = [[TYProfileViewModel alloc] initWithServices:self.services params:@{@"title" : @"Profile"}];
}

@end
