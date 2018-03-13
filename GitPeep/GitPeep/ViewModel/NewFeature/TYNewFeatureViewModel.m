//
//  TYNewFeatureViewModel.m
//  GitPeep
//
//  Created by tiany on 2018/1/15.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYNewFeatureViewModel.h"

#import "TYLoginViewModel.h"

@implementation TYNewFeatureViewModel

- (void)initialize {
    [super initialize];
    
    @weakify(self);
    self.didScrollCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id value) {
        @strongify(self);
        
        TYLoginViewModel *loginViewModel = [[TYLoginViewModel alloc] initWithServices:self.services params:nil];
        [self.services pushViewModel:loginViewModel animated:YES];
        
        return [RACSignal empty];
    }];
}

@end
