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
        
        [[TYNetworkEngine sharedInstance] searchUsersWithPage:self.page q:@"location:beijing" sort:@"followers" location:@"beijing" language:@"所有语言" completionHandle:^(NSDictionary *responseDictionary) {
            NSLog(@"response:%@", responseDictionary)

            NSMutableArray *array = [NSMutableArray array];
            NSArray *items = responseDictionary[@"items"];
            for (NSDictionary *itemDic in items) {
                TYUsersItemModel *model = [TYUsersItemModel yy_modelWithDictionary:itemDic];
                [array addObject:model];
            }
            
            if (self.prePage < self.page) {
                [self.modelArray addObjectsFromArray:array];
            } else {
                if (array.count > 0) {
                    self.modelArray = array;
                }
            }
            
            // 发送数据
            [subscriber sendNext:self.modelArray];
            [subscriber sendCompleted];
        } errorHandle:^(NSError *error) {
            NSLog(@"error:%@", error)
        }];
        
        return nil;
    }];
    return signal;
}

@end
