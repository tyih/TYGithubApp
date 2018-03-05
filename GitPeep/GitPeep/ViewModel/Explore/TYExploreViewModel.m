//
//  TYExploreViewModel.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/31.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYExploreViewModel.h"

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
    
    @weakify(self);
    self.requestTrendingReposCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        @weakify(self);
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            
//            [[TYNetworkEngine sharedInstance] userRepositoriesWithUserName:self.params[@"login"] page:1 completionHandle:^(NSArray *responseArray) {
            
                NSMutableArray *modelArray = [NSMutableArray array];
//                for (NSDictionary *dic in responseArray) {
                    //                TYRepositoriesItemModel *model = [TYRepositoriesItemModel yy_modelWithDictionary:dic];
                    //                [modelArray addObject:model];
//                }
                //            [subscriber sendNext:modelArray];
//                [subscriber sendCompleted];
                [[YYCache sharedCache] setObject:modelArray forKey:TYTrendingReposLanguageCacheKey];
                
//            } errorHandle:^(NSError *error) {
//                NSLog(@"error:%@", error)
//            }];
            return nil;
        }];
        return signal;
    }];
    
    self.popularReposLanguageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        @weakify(self);
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);

            NSMutableArray *modelArray = [NSMutableArray array];
            [[YYCache sharedCache] setObject:modelArray forKey:TYTrendingReposLanguageCacheKey];
            return nil;
        }];
        return signal;
    }];
    
    self.popularUsersReposCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        @weakify(self);
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            
            NSMutableArray *modelArray = [NSMutableArray array];
            [[YYCache sharedCache] setObject:modelArray forKey:TYPopularUsersReposCacheKey];
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
    
    RAC(self, dataArray) = [RACSignal combineLatest:@[RACObserve(self, trendingRepos), RACObserve(self, popularRepos), RACObserve(self, popularUsers)] reduce:^(NSArray *trendingRepos, NSArray *popularRepos, NSArray *popularUsers) {

        NSMutableArray *rows = [NSMutableArray array];
        if (trendingRepos.count > 0) {
            [rows addObject:trendingRepos];
        } else {
            [rows addObject:@[]];
        }
        if (popularRepos.count > 0) {
            [rows addObject:popularRepos];
        } else {
            [rows addObject:@[]];
        }
        if (popularUsers.count > 0) {
            [rows addObject:popularUsers];
        } else {
            [rows addObject:@[]];
        }
        return rows.copy;
    }];
    
    [self.requestTrendingReposCommand execute:nil];
    [self.popularReposLanguageCommand execute:nil];
    [self.popularUsersReposCommand execute:nil];
}

@end
