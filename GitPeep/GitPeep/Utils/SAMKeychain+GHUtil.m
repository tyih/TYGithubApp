//
//  SAMKeychain+GHUtil.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/23.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "SAMKeychain+GHUtil.h"

@implementation SAMKeychain (GHUtil)

+ (NSString *)password {
    
    return [self passwordForService:GH_SERVICE_NAME account:GH_PASSWORD];
}
+ (NSString *)accessToken {
    
    return [self passwordForService:GH_SERVICE_NAME account:GH_ACCESS_TOKEN];
}

+ (BOOL)setPassword:(NSString *)password {
    
    return [self setPassword:password forService:GH_SERVICE_NAME account:GH_PASSWORD];
}
+ (BOOL)setAccessToken:(NSString *)accessToken {
    
    return [self setPassword:accessToken forService:GH_SERVICE_NAME account:GH_PASSWORD];
}

+ (BOOL)deletePassword {
    
    return [self deletePasswordForService:GH_SERVICE_NAME account:GH_PASSWORD];
}
+ (BOOL)deleteAccessToken {
    
    return [self deletePasswordForService:GH_SERVICE_NAME account:GH_ACCESS_TOKEN];
}

@end
