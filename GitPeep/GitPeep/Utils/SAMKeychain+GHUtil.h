//
//  SAMKeychain+GHUtil.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/23.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <SAMKeychain/SAMKeychain.h>

@interface SAMKeychain (GHUtil)

+ (NSString *)password;
+ (NSString *)accessToken;

+ (BOOL)setPassword:(NSString *)password;
+ (BOOL)setAccessToken:(NSString *)accessToken;

+ (BOOL)deletePassword;
+ (BOOL)deleteAccessToken;

@end
