//
//  TYUserDetailViewModel.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/1.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYUserDetailViewModel.h"

#import "TYRepositoriesModel.h"
#import "TYUsersItemModel.h"

@interface TYUserDetailViewModel ()

// userDetail请求
@property (nonatomic, strong, readwrite) RACCommand *requestUserDetailCommand;

@end

@implementation TYUserDetailViewModel

- (void)initialize {
    [super initialize];
    
    @weakify(self);
    self.requestUserDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [[self requestUserDetail] takeUntil:self.rac_willDeallocSignal];
    }];
    
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self);
        
        switch (self.chooseType) {
            case UserDetailChooseTypeRepositories: {
                
            }
                break;
            case UserDetailChooseTypeFollowing: {
                TYUsersItemModel *model = self.dataArray[indexPath.row];
                [self.services pushViewModel:[[TYUserDetailViewModel alloc] initWithServices:self.services params:@{@"title" : @"UserDetail", @"login" : model.login}] animated:YES];}
                break;
            case UserDetailChooseTypeFollower: {
                TYUsersItemModel *model = self.dataArray[indexPath.row];
                [self.services pushViewModel:[[TYUserDetailViewModel alloc] initWithServices:self.services params:@{@"title" : @"UserDetail", @"login" : model.login}] animated:YES];}
                break;
        }
        return [RACSignal empty];
    }];
}

// 请求userDetail
- (RACSignal *)requestUserDetail {
    
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        [[TYNetworkEngine sharedInstance] userDetailWithUserName:self.params[@"login"] completionHandle:^(NSDictionary *responseDictionary) {
            
            TYUserDetailModel *model = [TYUserDetailModel yy_modelWithDictionary:responseDictionary];
            // 发送数据
            [subscriber sendNext:model];
            [subscriber sendCompleted];
        } errorHandle:^(NSError *error) {
            NSLog(@"error:%@", error)
        }];
        
        return nil;
    }];
    return signal;
}

/// 请求列表
- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        NSMutableArray *modelArray = [NSMutableArray array];
        
        switch (self.chooseType) {
            case UserDetailChooseTypeRepositories: {
                [[TYNetworkEngine sharedInstance] userRepositoriesWithUserName:self.params[@"login"] page:page completionHandle:^(NSArray *responseArray) {
                    
                    for (NSDictionary *dic in responseArray) {
                        TYRepositoriesModel *model = [TYRepositoriesModel yy_modelWithDictionary:dic];
                        [modelArray addObject:model];
                    }
                    [subscriber sendNext:modelArray];
                    [subscriber sendCompleted];
                } errorHandle:^(NSError *error) {
                    NSLog(@"error:%@", error)
                }];}
                break;
            case UserDetailChooseTypeFollowing: {
                [[TYNetworkEngine sharedInstance] userFollowingWithUserName:self.params[@"login"] page:page completionHandle:^(NSArray *responseArray) {
                    
                    for (NSDictionary *dic in responseArray) {
                        TYUsersItemModel *model = [TYUsersItemModel yy_modelWithDictionary:dic];
                        [modelArray addObject:model];
                    }
                    [subscriber sendNext:modelArray];
                    [subscriber sendCompleted];
                } errorHandle:^(NSError *error) {
                    NSLog(@"error:%@", error)
                }];}
                break;
            case UserDetailChooseTypeFollower: {
                [[TYNetworkEngine sharedInstance] userFollowersWithUserName:self.params[@"login"] page:page completionHandle:^(NSArray *responseArray) {
                    
                    for (NSDictionary *dic in responseArray) {
                        TYUsersItemModel *model = [TYUsersItemModel yy_modelWithDictionary:dic];
                        [modelArray addObject:model];
                    }
                    [subscriber sendNext:modelArray];
                    [subscriber sendCompleted];
                } errorHandle:^(NSError *error) {
                    NSLog(@"error:%@", error)
                }];}
                break;
        }

        return nil;
    }];
    return signal;
}

@end
