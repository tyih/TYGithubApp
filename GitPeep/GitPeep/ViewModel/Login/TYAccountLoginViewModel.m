//
//  TYAccountLoginViewModel.m
//  GitPeep
//
//  Created by tiany on 2018/1/15.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYAccountLoginViewModel.h"

#import "TYViewModelServicesProtocol.h"
#import "TYMainViewModel.h"

@interface TYAccountLoginViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *loginCommand;

@end

@implementation TYAccountLoginViewModel

- (void)initialize {
    [super initialize];
    
    @weakify(self);
    void (^doNext)(OCTClient *) = ^(OCTClient *authenticatedClient) {
        @strongify(self);
        
//        self.services.client = authenticatedClient;
        
        SAMKeychain.rawLogin = authenticatedClient.user.rawLogin;
        SAMKeychain.password = self.password;
        SAMKeychain.accessToken = authenticatedClient.token;
        
        TYMainViewModel *viewModel = [[TYMainViewModel alloc] initWithServices:self.services params:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.services resetRootViewModel:viewModel];
        });
    };
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        OCTUser *user = [OCTUser userWithRawLogin:self.username server:OCTServer.dotComServer];
        return [[OCTClient signInAsUser:user password:self.password oneTimePassword:input scopes:OCTClientAuthorizationScopesUser | OCTClientAuthorizationScopesRepository note:nil noteURL:nil fingerprint:nil] doNext:doNext];
    }];
}

@end
