//
//  TYUserDetailViewModel.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/1.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYUserDetailViewModel.h"

@interface TYUserDetailViewModel ()

// userDetail请求
@property (nonatomic, strong, readwrite) RACCommand *requestUserDetailCommand;

@end

@implementation TYUserDetailViewModel

- (void)initialize {
    [super initialize];
    
    self.requestUserDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [[self requestUserDetail] takeUntil:self.rac_willDeallocSignal];
    }];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        NSMutableArray *viewModelArray = [NSMutableArray array];
        [[TYNetworkEngine sharedInstance] userDetailWithUserName:self.params[@"login"] completionHandle:^(NSDictionary *responseDictionary) {
            
            NSArray *items = responseDictionary[@"items"];
            for (NSDictionary *itemDic in items) {
//                TYUsersItemViewModel *viewModel = [[TYUsersItemViewModel alloc] initWithDictionary:itemDic];
//                [viewModelArray addObject:viewModel];
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

@end
