//
//  TYWebViewModel.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/23.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYWebViewModel.h"

@implementation TYWebViewModel

- (instancetype)initWithServices:(id<TYViewModelServices>)services params:(NSDictionary *)params {
    
    self = [super initWithServices:services params:params];
    if (self) {
        self.request = params[@"request"];
    }
    return self;
}

@end
