//
//  TYNewsViewModel.m
//  GitPeep
//
//  Created by tiany on 2018/1/15.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYNewsViewModel.h"

@implementation TYNewsViewModel

- (instancetype)initWithServices:(id<TYViewModelServices>)services params:(NSDictionary *)params {
    
    self = [super initWithServices:services params:params];
    if (self) {
        
    }
    return self;
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSArray *dictArray = @[@{@"title" : @"xxxxxx", @"time" : @"9999999"},
                               @{@"title" : @"yyyyyy", @"time" : @"1111111"},
                               @{@"title" : @"zzzzzz", @"time" : @"2222222"},
                               @{@"title" : @"tttttt", @"time" : @"3333333"}];
            [subscriber sendNext:dictArray];
        return nil;
    }];
    
    return signal;
}

@end
