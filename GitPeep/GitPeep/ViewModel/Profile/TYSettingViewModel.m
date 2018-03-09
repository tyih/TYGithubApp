//
//  TYSettingViewModel.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/9.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYSettingViewModel.h"

#import "TYUserDetailViewModel.h"
#import "TYLoginViewModel.h"

@implementation TYSettingViewModel

- (instancetype)initWithServices:(id<TYViewModelServices>)services params:(NSDictionary *)params {
    
    self = [super initWithServices:services params:params];
    if (self) {
        
        self.dataArray = @[@[@"Account"], @[@"About"], @[@"Sign out"]];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    @weakify(self);
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self);
        
        switch (indexPath.section) {
            case 0: {
                // 进入我的仓库
                [self.services pushViewModel:[[TYUserDetailViewModel alloc] initWithServices:self.services params:@{@"title" : @"UserDetail", @"login" : self.params[@"login"]}] animated:YES];
            }
                break;
            case 1: {
                // 关于
            }
                break;
            case 2: {
                // 退出
                [SAMKeychain deleteAccessToken];
                
                TYLoginViewModel *loginViewModel = [[TYLoginViewModel alloc] initWithServices:self.services params:nil];
                [self.services resetRootViewModel:loginViewModel];
            }
                break;
                
            default:
                break;
        }

        return [RACSignal empty];
    }];
}

@end
