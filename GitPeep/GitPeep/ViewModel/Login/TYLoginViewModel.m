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
#import "TYOAuthViewModel.h"

@interface TYLoginViewModel ()

@property (nonatomic, strong, readwrite) RACSignal *validLoginSignal;

@property (nonatomic, strong, readwrite) RACCommand *loginCommand;

@property (nonatomic, strong, readwrite) RACCommand *browserLoginCommand;

@end

@implementation TYLoginViewModel

- (void)initialize {
    [super initialize];
    
    // 账号、密码输入有效signal
    self.validLoginSignal = [[RACSignal combineLatest:@[RACObserve(self, username), RACObserve(self, password)] reduce:^(NSString *username, NSString *password) {
        
        return @(username.length > 0 && password.length > 0);
    }] distinctUntilChanged];
    
    @weakify(self);
    void (^doNext)(OCTClient *) = ^(OCTClient *authenticatedClient) {
        @strongify(self);
        // 登录成功
        self.services.client = authenticatedClient;
        
        SAMKeychain.rawLogin = authenticatedClient.user.rawLogin;
        SAMKeychain.password = self.password;
        SAMKeychain.accessToken = authenticatedClient.token;
        
        // 展示首页
        TYMainViewModel *viewModel = [[TYMainViewModel alloc] initWithServices:self.services params:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.services resetRootViewModel:viewModel];
        });
    };
    // 设置CLIENT_ID
    [OCTClient setClientID:TY_CLIENT_ID clientSecret:TY_CLIENT_SECRET];
    
    // 登录触发
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        
        NSLog(@"username:%@, password:%@", self.username, self.password);
        OCTUser *user = [OCTUser userWithRawLogin:self.username server:OCTServer.dotComServer];
        return [[OCTClient signInAsUser:user password:self.password oneTimePassword:input scopes:OCTClientAuthorizationScopesUser | OCTClientAuthorizationScopesRepository note:nil noteURL:nil fingerprint:nil] doNext:doNext];
    }];
    
    // 浏览器登录
    self.browserLoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        TYOAuthViewModel *viewModel = [[TYOAuthViewModel alloc] initWithServices:self.services params:nil];
        viewModel.callback = ^(NSString *code) {
            @strongify(self);
            [self.services popViewModelAnimated:YES];
            // 请求token
            [self.browserLoginCommand execute:code];
        };
        [self.services pushViewModel:viewModel animated:YES];
        
        return [RACSignal empty];
    }];
    
    self.browserLoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *code) {
        
        OCTClient *client = [[OCTClient alloc] initWithServer:[OCTServer dotComServer]];
        
        return [[[[[client exchangeAccessTokenWithCode:code] doNext:^(OCTAccessToken *accessToken) {
            
            [client setValue:accessToken.token forKey:@"token"];
        }] flattenMap:^(id value) {
            
            return [[client fetchUserInfo] doNext:^(OCTUser *user) {
                NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
                
                [mutableDictionary addEntriesFromDictionary:user.dictionaryValue];
                
                if (user.rawLogin.length == 0) {
                    mutableDictionary[@keypath(user.rawLogin)] = user.login;
                }
                user = [OCTUser modelWithDictionary:mutableDictionary error:NULL];
                
                [client setValue:user forKey:@"user"];
            }];
        }] mapReplace:client] doNext:doNext];
    }];
}

@end
