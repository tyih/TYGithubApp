//
//  OCTUser+TYLogin.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/9.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "OCTUser+TYLogin.h"

@implementation OCTUser (TYLogin)

+ (instancetype)gp_userWithRawLogin:(NSString *)rawLogin server:(OCTServer *)server {
    
    NSParameterAssert(rawLogin.length > 0);
    NSParameterAssert(server);
    
    NSString *login = [SAMKeychain login];
    NSParameterAssert(login);

    NSMutableDictionary *userDic = [NSMutableDictionary dictionary];
    userDic[@"rawLogin"] = rawLogin;
    userDic[@"login"] = login;
    userDic[@"baseUrl"] = server.baseURL;
    
    return [self modelWithDictionary:userDic error:NULL];
}

@end
