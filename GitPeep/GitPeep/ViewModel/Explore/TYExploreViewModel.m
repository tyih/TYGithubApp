//
//  TYExploreViewModel.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/31.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYExploreViewModel.h"

#import "TYRepositoriesItemModel.h"
#import "TYExploreItemCellViewModel.h"
#import "TYExploreCollectionViewCellViewModel.h"
#import "TYRepositoriesViewModel.h"
#import "TYUsersViewModel.h"
#import "TYRepositoriesDetailViewModel.h"
#import "TYUserDetailViewModel.h"

@interface TYExploreViewModel ()

@property (nonatomic, copy) NSArray *trendingRepos;

@property (nonatomic, copy) NSArray *popularRepos;

@property (nonatomic, copy) NSArray *popularUsers;

@property (nonatomic, strong, readwrite) RACCommand *requestTrendingReposCommand;

@property (nonatomic, strong, readwrite) RACCommand *popularReposLanguageCommand;

@property (nonatomic, strong, readwrite) RACCommand *popularUsersReposCommand;

@end

@implementation TYExploreViewModel

- (void)initialize {
    [super initialize];
    
    self.requestTrendingReposCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [[TYNetworkEngine sharedInstance] searchRepositoriesWithPage:1 q:@"language:Objective-C" sort:@"stars" completionHandle:^(NSDictionary *responseDictionary) {
                
                [[YYCache sharedCache] setObject:responseDictionary[@"items"] forKey:TYTrendingReposLanguageCacheKey];
            } errorHandle:^(NSError *error) {
                NSLog(@"error:%@", error)
            }];
            return nil;
        }];
        return signal;
        
    }];
    
    self.popularReposLanguageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [[TYNetworkEngine sharedInstance] searchRepositoriesWithPage:1 q:@"language:PHP" sort:@"stars" completionHandle:^(NSDictionary *responseDictionary) {
                
                [[YYCache sharedCache] setObject:responseDictionary[@"items"] forKey:TYPopularReposLanguageCacheKey];
            } errorHandle:^(NSError *error) {
                NSLog(@"error:%@", error)
            }];
            return nil;
        }];
        return signal;
        
    }];
    
    self.popularUsersReposCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [[TYNetworkEngine sharedInstance] searchUsersWithPage:1 q:@"location:beijing" sort:@"followers" location:@"beijing" language:@"all languages" completionHandle:^(NSDictionary *responseDictionary) {
                
                [[YYCache sharedCache] setObject:responseDictionary[@"items"] forKey:TYPopularUsersReposCacheKey];
            } errorHandle:^(NSError *error) {
                NSLog(@"error:%@", error)
            }];
            return nil;
        }];
        return signal;
        
    }];
    
    self.trendingRepos = (NSArray *)[[YYCache sharedCache] objectForKey:TYTrendingReposLanguageCacheKey];
    self.popularRepos = (NSArray *)[[YYCache sharedCache] objectForKey:TYPopularReposLanguageCacheKey];
    self.popularUsers = (NSArray *)[[YYCache sharedCache] objectForKey:TYPopularUsersReposCacheKey];
    
    RAC(self, trendingRepos) = self.requestTrendingReposCommand.executionSignals.switchToLatest;
    RAC(self, popularRepos) = self.popularReposLanguageCommand.executionSignals.switchToLatest;
    RAC(self, popularUsers) = self.popularUsersReposCommand.executionSignals.switchToLatest;
    
    @weakify(self);
    RACCommand *didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(TYExploreCollectionViewCellViewModel *viewModel) {
        @strongify(self);
        
        if ([viewModel.model isKindOfClass:[TYRepositoriesItemModel class]]) {
            
            TYRepositoriesItemModel *model = viewModel.model;
            [self.services pushViewModel:[[TYRepositoriesDetailViewModel alloc] initWithServices:self.services params:@{@"title" : @"RepositoriesDetail", @"login" : model.owner.login, @"repositoryName" : model.name}] animated:YES];
        } else if ([viewModel.model isKindOfClass:[TYUsersItemModel class]]) {
            
            TYUsersItemModel *model = viewModel.model;
            [self.services pushViewModel:[[TYUserDetailViewModel alloc] initWithServices:self.services params:@{@"title" : @"UserDetail", @"login" : model.login}] animated:YES];
        }
        
        return [RACSignal empty];
    }];
    
    RAC(self, dataArray) = [RACSignal combineLatest:@[RACObserve(self, trendingRepos), RACObserve(self, popularRepos), RACObserve(self, popularUsers)] reduce:^(NSArray *trendingRepos, NSArray *popularRepos, NSArray *popularUsers) {

        NSMutableArray *rows = [NSMutableArray array];
        if (trendingRepos.count > 0) {
            
            NSMutableArray *viewModelArray = [NSMutableArray array];
            for (int i=0; i<20; i++) {
                NSDictionary *dic = trendingRepos[i];
                TYRepositoriesItemModel *model = [TYRepositoriesItemModel yy_modelWithDictionary:dic];
                TYExploreCollectionViewCellViewModel *viewModel = [[TYExploreCollectionViewCellViewModel alloc] init];
                viewModel.model = model;
                viewModel.avatarUrl = model.owner.avatar_url;
                viewModel.name = model.name;
                viewModel.didSelectCommand = didSelectCommand;
                [viewModelArray addObject:viewModel];
            }

            TYExploreItemCellViewModel *cellViewModel = [[TYExploreItemCellViewModel alloc] init];
            cellViewModel.title = @"Popular Repositories";
            cellViewModel.collectionCellViewModels = viewModelArray;
            
            
            cellViewModel.seeAllCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                @strongify(self);
                
                TYRepositoriesViewModel *viewModel = [[TYRepositoriesViewModel alloc] initWithServices:self.services params:nil];
                [self.services pushViewModel:viewModel animated:YES];
                
                return [RACSignal empty];
            }];
            
            [rows addObject:cellViewModel];
        } else {
            [rows addObject:[[TYExploreItemCellViewModel alloc] init]];
        }
        if (popularRepos.count > 0) {
            
            NSMutableArray *viewModelArray = [NSMutableArray array];
            for (int i=0; i<20; i++) {
                NSDictionary *dic = popularRepos[i];
                TYRepositoriesItemModel *model = [TYRepositoriesItemModel yy_modelWithDictionary:dic];
                TYExploreCollectionViewCellViewModel *viewModel = [[TYExploreCollectionViewCellViewModel alloc] init];
                viewModel.model = model;
                viewModel.avatarUrl = model.owner.avatar_url;
                viewModel.name = model.name;
                viewModel.didSelectCommand = didSelectCommand;
                [viewModelArray addObject:viewModel];
            }
            
            TYExploreItemCellViewModel *cellViewModel = [[TYExploreItemCellViewModel alloc] init];
            cellViewModel.title = @"Popular Languages";
            cellViewModel.collectionCellViewModels = viewModelArray;
            
            cellViewModel.seeAllCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                @strongify(self);
                
                TYRepositoriesViewModel *viewModel = [[TYRepositoriesViewModel alloc] initWithServices:self.services params:nil];
                [self.services pushViewModel:viewModel animated:YES];
                
                return [RACSignal empty];
            }];
            
            [rows addObject:cellViewModel];
        } else {
            [rows addObject:[[TYExploreItemCellViewModel alloc] init]];
        }
        if (popularUsers.count > 0) {
            
            NSMutableArray *viewModelArray = [NSMutableArray array];
            for (int i=0; i<20; i++) {
                NSDictionary *dic = popularUsers[i];
                TYUsersItemModel *model = [TYUsersItemModel yy_modelWithDictionary:dic];
                TYExploreCollectionViewCellViewModel *viewModel = [[TYExploreCollectionViewCellViewModel alloc] init];
                viewModel.model = model;
                viewModel.avatarUrl = model.avatar_url;
                viewModel.name = model.login;
                viewModel.didSelectCommand = didSelectCommand;
                [viewModelArray addObject:viewModel];
            }
            
            TYExploreItemCellViewModel *cellViewModel = [[TYExploreItemCellViewModel alloc] init];
            cellViewModel.title = @"Popular Users";
            cellViewModel.collectionCellViewModels = viewModelArray;
            
            cellViewModel.seeAllCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                @strongify(self);
                
                TYUsersViewModel *viewModel = [[TYUsersViewModel alloc] initWithServices:self.services params:nil];
                [self.services pushViewModel:viewModel animated:YES];
                
                return [RACSignal empty];
            }];
            
            [rows addObject:cellViewModel];
        } else {
            [rows addObject:[[TYExploreItemCellViewModel alloc] init]];
        }
        return rows.copy;
    }];
    
    [self.requestTrendingReposCommand execute:nil];
    [self.popularReposLanguageCommand execute:nil];
    [self.popularUsersReposCommand execute:nil];
}

@end
