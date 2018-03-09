//
//  OCTUser+TYLogin.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/9.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <OctoKit/OctoKit.h>

@interface OCTUser (TYLogin)

+ (instancetype)gp_userWithRawLogin:(NSString *)rawLogin server:(OCTServer *)server;

@end
