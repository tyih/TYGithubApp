//
//  SAMKeychain+GHUtil.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/23.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <SAMKeychain/SAMKeychain.h>

@interface SAMKeychain (GHUtil)

+ (NSString *)rawLogin;
+ (NSString *)password;
+ (NSString *)accessToken;

+ (BOOL)setRawLogin:(NSString *)rawLogin;
+ (BOOL)setPassword:(NSString *)password;
+ (BOOL)setAccessToken:(NSString *)accessToken;

+ (BOOL)deleteRawLogin;
+ (BOOL)deletePassword;
+ (BOOL)deleteAccessToken;

@end
