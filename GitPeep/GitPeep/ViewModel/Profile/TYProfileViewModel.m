//
//  TYProfileViewModel.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/31.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYProfileViewModel.h"

#import "TYSettingViewModel.h"

@implementation TYProfileViewModel

- (void)initialize {
    [super initialize];
    
    @weakify(self);
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self);
        
        [self.services pushViewModel:[[TYSettingViewModel alloc] initWithServices:self.services params:@{@"title" : @"Settings", @"login" : self.userModel.login}] animated:YES];
        return [RACSignal empty];
    }];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        NSString *login = self.services.client.user.login;
        [[TYNetworkEngine sharedInstance] userDetailWithUserName:login completionHandle:^(NSDictionary *responseDictionary) {
            
            TYUserDetailModel *model = [TYUserDetailModel yy_modelWithDictionary:responseDictionary];
            self.userModel = model;
            // 公司 定位 邮件 博客
            NSString *company = model.company ? model.company : @"";
            NSString *location = model.location ? model.location : @"";
            NSString *email = model.email ? model.email : @"";
            NSString *blog = model.blog ? model.blog : @"";
            NSArray *detailArray = @[@[company, location, email, blog], @[@"Settings"]];
            // 发送数据
            [subscriber sendNext:detailArray];
            [subscriber sendCompleted];
        } errorHandle:^(NSError *error) {
            NSLog(@"error:%@", error)
        }];
        
        return nil;
    }];
    return signal;
}

@end
