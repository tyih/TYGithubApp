//
//  TYViewModel.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/3.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYViewModel.h"

@interface TYViewModel ()

@property (nonatomic, strong, readwrite) id<TYViewModelServices> services;

@property (nonatomic, strong, readwrite) NSDictionary *params;


@property (nonatomic, strong, readwrite) RACSubject *errors;
@property (nonatomic, strong, readwrite) RACSubject *willDisappearSignal;

@end

@implementation TYViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    TYViewModel *viewModel = [super allocWithZone:zone];
    @weakify(viewModel);
    [[viewModel rac_signalForSelector:@selector(initWithServices:params:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(viewModel);
        [viewModel initialize]; // 使用 initWithServices:params: 初始化时调用此方法
    }];
    
    return viewModel;
}

- (instancetype)initWithServices:(id<TYViewModelServices>)services params:(NSDictionary *)params {
    
    self = [super init];
    if (self) {
        self.services = services;
        self.params = params;
        self.title = params[@"title"];
    }
    return self;
}

- (RACSubject *)errors {
    
    if (!_errors) {
        _errors = [RACSubject subject];
    }
    return _errors;
}

- (RACSubject *)willDisappearSignal {
    
    if (!_willDisappearSignal) {
        _willDisappearSignal = [RACSubject subject];
    }
    return _willDisappearSignal;
}

- (void)initialize {}

@end
