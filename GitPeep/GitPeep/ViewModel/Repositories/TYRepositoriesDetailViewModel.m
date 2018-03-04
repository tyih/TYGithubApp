//
//  TYRepositoriesDetailViewModel.m
//  GitPeep
//
//  Created by tiany on 2018/3/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYRepositoriesDetailViewModel.h"

#import "TYRepositoriesItemModel.h"
#import "TYUsersItemModel.h"
#import "TYUserDetailViewModel.h"

@interface TYRepositoriesDetailViewModel ()

// reposDetail请求
@property (nonatomic, strong, readwrite) RACCommand *requestReposDetailCommand;

@end

@implementation TYRepositoriesDetailViewModel

- (void)initialize {
    [super initialize];
    
    @weakify(self);
    self.requestReposDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [[self requestReposDetail] takeUntil:self.rac_willDeallocSignal];
    }];
    
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self);
        TYUsersItemModel *model = self.dataArray[indexPath.row];
        [self.services pushViewModel:[[TYUserDetailViewModel alloc] initWithServices:self.services params:@{@"title" : @"UserDetail", @"login" : model.login}] animated:YES];
        return [RACSignal empty];
    }];
}

// 请求reposDetail
- (RACSignal *)requestReposDetail {
    
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        [[TYNetworkEngine sharedInstance] repositoryDetailWithUserName:self.params[@"login"] repositoryName:self.params[@"repositoryName"] completionHandle:^(NSDictionary *responseDictionary) {
            
            TYRepositoriesItemModel *model = [TYRepositoriesItemModel yy_modelWithDictionary:responseDictionary];
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
        NSString *category = nil;
        switch (self.chooseType) {
            case TYTabButtonsTypeFirst:
                category = @"contributors";
                break;
            case TYTabButtonsTypeSecond:
                category = @"forks";
                break;
            case TYTabButtonsTypeThird:
                category = @"stargazers";
                break;
        }
        [[TYNetworkEngine sharedInstance] reposDetailCategoryWithUserName:self.params[@"login"] page:page repositoryName:self.params[@"repositoryName"] category:category completionHandle:^(NSArray *responseArray) {
            for (NSDictionary *dic in responseArray) {
                if (self.chooseType == TYTabButtonsTypeSecond) {
                    TYRepositoriesItemModel *model = [TYRepositoriesItemModel yy_modelWithDictionary:dic];
                    [modelArray addObject:model];
                } else {
                    TYUsersItemModel *model = [TYUsersItemModel yy_modelWithDictionary:dic];
                    [modelArray addObject:model];
                }
            }
            [subscriber sendNext:modelArray];
            [subscriber sendCompleted];
        } errorHandle:^(NSError *error) {
            NSLog(@"error:%@", error)
        }];
        
        return nil;
    }];
    return signal;
}

@end
