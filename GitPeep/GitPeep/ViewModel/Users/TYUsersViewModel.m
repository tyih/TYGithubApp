//
//  TYUsersViewModel.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/28.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYUsersViewModel.h"

#import "TYUsersItemModel.h"
#import "TYUserDetailViewModel.h"

@interface TYUsersViewModel ()

@end

@implementation TYUsersViewModel

- (void)initialize {
    [super initialize];
    
    @weakify(self);
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self);
        
        TYUsersItemModel *model = self.dataArray[indexPath.row];
        [self.services pushViewModel:[[TYUserDetailViewModel alloc] initWithServices:self.services params:@{@"title" : @"UserDetail", @"login" : model.login}] animated:YES];
        return [RACSignal empty];
    }];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        NSMutableArray *modelArray = [NSMutableArray array];
        [[TYNetworkEngine sharedInstance] searchUsersWithPage:1 q:@"location:beijing" sort:@"followers" location:@"beijing" language:@"所有语言" completionHandle:^(NSDictionary *responseDictionary) {
            NSLog(@"response:%@", responseDictionary)
            
            NSArray *items = responseDictionary[@"items"];
            for (NSDictionary *itemDic in items) {
                TYUsersItemModel *model = [TYUsersItemModel yy_modelWithDictionary:itemDic];
                [modelArray addObject:model];
            }
            // 发送数据
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
