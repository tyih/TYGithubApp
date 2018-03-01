//
//  TYUsersViewModel.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/28.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYUsersViewModel.h"

#import "TYUsersItemViewModel.h"
#import "TYUserDetailViewModel.h"

@interface TYUsersViewModel ()

@end

@implementation TYUsersViewModel

- (void)initialize {
    [super initialize];
    
    @weakify(self);
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self);
        
        TYUsersItemModel *model = ((TYUsersItemViewModel *)self.dataArray[indexPath.row]).model;
        [self.services pushViewModel:[[TYUserDetailViewModel alloc] initWithServices:self.services params:@{@"title" : @"UserDetail", @"login" : model.login}] animated:YES];
        return [RACSignal empty];
    }];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        NSMutableArray *viewModelArray = [NSMutableArray array];
        [[TYNetworkEngine sharedInstance] searchUsersWithPage:1 q:@"location:beijing" sort:@"followers" location:@"beijing" language:@"所有语言" completionHandle:^(NSDictionary *responseDictionary) {
            NSLog(@"response:%@", responseDictionary)
            
            NSArray *items = responseDictionary[@"items"];
            for (NSDictionary *itemDic in items) {
                TYUsersItemViewModel *viewModel = [[TYUsersItemViewModel alloc] initWithDictionary:itemDic];
                [viewModelArray addObject:viewModel];
                NSLog(@"identifier:%ld", viewModel.model.userId)
            }
            // 发送数据
            [subscriber sendNext:viewModelArray];
            [subscriber sendCompleted];
        } errorHandle:^(NSError *error) {
            NSLog(@"error:%@", error)
        }];
        
        return nil;
    }];
    return signal;
}

@end
