//
//  TYRepositoriesViewModel.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/31.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYRepositoriesViewModel.h"

#import "TYRepositoriesItemModel.h"
#import "TYRepositoriesDetailViewModel.h"

@implementation TYRepositoriesViewModel

- (void)initialize {
    [super initialize];
    
    @weakify(self);
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self);
        TYRepositoriesItemModel *model = self.dataArray[indexPath.row];
        [self.services pushViewModel:[[TYRepositoriesDetailViewModel alloc] initWithServices:self.services params:@{@"title" : @"RepositoriesDetail", @"login" : model.owner.login, @"repositoryName" : model.name}] animated:YES];
        return [RACSignal empty];
    }];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        NSMutableArray *modelArray = [NSMutableArray array];
        [[TYNetworkEngine sharedInstance] searchRepositoriesWithPage:page q:@"language:JavaScript" sort:@"stars" completionHandle:^(NSDictionary *responseDictionary) {
            
            NSArray *items = responseDictionary[@"items"];
            for (NSDictionary *itemDic in items) {
                TYRepositoriesItemModel *model = [TYRepositoriesItemModel yy_modelWithDictionary:itemDic];
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
