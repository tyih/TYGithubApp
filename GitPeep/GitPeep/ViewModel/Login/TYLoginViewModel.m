//
//  TYLoginViewModel.m
//  GitPeep
//
//  Created by tiany on 2018/1/15.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYLoginViewModel.h"

#import "TYViewModelServices.h"
#import "TYMainViewModel.h"

@interface TYLoginViewModel ()

@property (nonatomic, strong, readwrite) RACSignal *validLoginSignal;

@property (nonatomic, strong, readwrite) RACCommand *loginCommand;

@end

@implementation TYLoginViewModel

- (void)initialize {
    [super initialize];
    
    self.validLoginSignal = [[RACSignal combineLatest:@[RACObserve(self, username), RACObserve(self, password)] reduce:^(NSString *username, NSString *password) {
        
        return @(username.length > 0 && password.length > 0);
    }] distinctUntilChanged];
    
    @weakify(self);
    void (^doNext)(OCTClient *) = ^(OCTClient *authenticatedClient) {
        @strongify(self);
        
        self.services.client = authenticatedClient;
        
        SAMKeychain.rawLogin = authenticatedClient.user.rawLogin;
        SAMKeychain.password = self.password;
        SAMKeychain.accessToken = authenticatedClient.token;
        
        TYMainViewModel *viewModel = [[TYMainViewModel alloc] initWithServices:self.services params:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.services resetRootViewModel:viewModel];
        });
    };
    
    [OCTClient setClientID:TY_CLIENT_ID clientSecret:TY_CLIENT_SECRET];
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        
        NSLog(@"username:%@, password:%@", self.username, self.password);
        OCTUser *user = [OCTUser userWithRawLogin:self.username server:OCTServer.dotComServer];
        return [[OCTClient signInAsUser:user password:self.password oneTimePassword:input scopes:OCTClientAuthorizationScopesUser note:nil noteURL:nil fingerprint:nil] doNext:doNext];
    }];
}

@end
