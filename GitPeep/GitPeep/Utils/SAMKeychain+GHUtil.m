//
//  SAMKeychain+GHUtil.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/23.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "SAMKeychain+GHUtil.h"

@implementation SAMKeychain (GHUtil)

+ (NSString *)rawLogin {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:GH_RAW_LOGIN];
}
+ (NSString *)password {
    
    return [self passwordForService:GH_SERVICE_NAME account:GH_PASSWORD];
}
+ (NSString *)accessToken {
    
    return [self passwordForService:GH_SERVICE_NAME account:GH_ACCESS_TOKEN];
}

+ (BOOL)setRawLogin:(NSString *)rawLogin {
    
    [[NSUserDefaults standardUserDefaults] setObject:rawLogin forKey:GH_RAW_LOGIN];
    return [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)setPassword:(NSString *)password {
    
    return [self setPassword:password forService:GH_SERVICE_NAME account:GH_PASSWORD];
}
+ (BOOL)setAccessToken:(NSString *)accessToken {
    
    return [self setPassword:accessToken forService:GH_SERVICE_NAME account:GH_PASSWORD];
}

+ (BOOL)deleteRawLogin {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:GH_RAW_LOGIN];
    return [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)deletePassword {
    
    return [self deletePasswordForService:GH_SERVICE_NAME account:GH_PASSWORD];
}
+ (BOOL)deleteAccessToken {
    
    return [self deletePasswordForService:GH_SERVICE_NAME account:GH_ACCESS_TOKEN];
}

@end
