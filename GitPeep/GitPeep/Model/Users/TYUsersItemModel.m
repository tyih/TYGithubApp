//
//  TYUsersModel.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/1.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYUsersItemModel.h"

@interface TYUsersItemModel ()

@property (nonatomic, copy, readwrite) NSString *avatar_url;

@property (nonatomic, copy, readwrite) NSString *events_url;

@property (nonatomic, copy, readwrite) NSString *followers_url;

@property (nonatomic, copy, readwrite) NSString *following_url;

@property (nonatomic, copy, readwrite) NSString *gists_url;

@property (nonatomic, copy, readwrite) NSString *gravatar_id;

@property (nonatomic, copy, readwrite) NSString *html_url;

@property (nonatomic, copy, readwrite) NSString *login;

@property (nonatomic, copy, readwrite) NSString *organizations_url;

@property (nonatomic, copy, readwrite) NSString *received_events_url;

@property (nonatomic, copy, readwrite) NSString *repos_url;

@property (nonatomic, copy, readwrite) NSString *starred_url;

@property (nonatomic, copy, readwrite) NSString *subscriptions_url;

@property (nonatomic, copy, readwrite) NSString *type;

@property (nonatomic, copy, readwrite) NSString *url;

@property (nonatomic, assign, readwrite) NSInteger userId;

@property (nonatomic, assign, readwrite) BOOL site_admin;

@property (nonatomic, assign, readwrite) CGFloat score;

@end

@implementation TYUsersItemModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{
             @"userId" : @"id"
             };
}

@end
