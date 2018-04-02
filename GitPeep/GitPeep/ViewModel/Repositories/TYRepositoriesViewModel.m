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
        
        [[TYNetworkEngine sharedInstance] searchRepositoriesWithPage:self.page q:@"language:JavaScript" sort:@"stars" completionHandle:^(NSDictionary *responseDictionary) {
            
            NSMutableArray *array = [NSMutableArray array];
            NSArray *items = responseDictionary[@"items"];
            for (NSDictionary *itemDic in items) {
                TYRepositoriesItemModel *model = [TYRepositoriesItemModel yy_modelWithDictionary:itemDic];
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
