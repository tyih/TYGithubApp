//
//  TYNewsViewModel.m
//  GitPeep
//
//  Created by tiany on 2018/1/15.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYNewsViewModel.h"

#import "TYNewsItemViewModel.h"

@interface TYNewsViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *didClickLinkCommand;

@end

@implementation TYNewsViewModel

- (instancetype)initWithServices:(id<TYViewModelServices>)services params:(NSDictionary *)params {
    
    self = [super initWithServices:services params:params];
    if (self) {
        
    }
    return self;
}

- (void)initialize {
    
    [super initialize];
        
    @weakify(self);
    self.didClickLinkCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSURL *url) {
        @strongify(self);
        // 点击事件
        NSLog(@"url: %@", url)
        return [RACSignal empty];
    }];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(2);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *dictArray = @[@{@"title" : @"xxxxxx", @"time" : @"9999999"},
                                       @{@"title" : @"yyyyyy", @"time" : @"1111111"},
                                       @{@"title" : @"zzzzzz", @"time" : @"2222222"},
                                       @{@"title" : @"tttttt", @"time" : @"3333333"}];
                NSMutableArray *dataArr = [NSMutableArray array];
                for (NSDictionary *dic in dictArray) {
                    TYNewsItemViewModel *model = [[TYNewsItemViewModel alloc] initWithTitle:dic[@"title"] time:dic[@"time"]];
                    model.didClickLinkCommand = self.didClickLinkCommand;
                    [dataArr addObject:model];
                }
                [subscriber sendNext:dataArr];
                [subscriber sendCompleted];
            });
        });
        
        return nil;
    }];
    
    return signal;
}

@end
