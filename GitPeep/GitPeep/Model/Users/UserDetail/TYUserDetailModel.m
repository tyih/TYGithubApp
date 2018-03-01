//
//  TYUserDetailModel.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/1.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYUserDetailModel.h"

@interface TYUserDetailModel ()

@property (nonatomic, copy, readwrite) NSString *avatar_url;

@property (nonatomic, copy, readwrite) NSString *bio;

@property (nonatomic, copy, readwrite) NSString *blog;

@property (nonatomic, copy, readwrite) NSString *created_at;

@property (nonatomic, copy, readwrite) NSString *email;

@property (nonatomic, copy, readwrite) NSString *events_url;

@property (nonatomic, assign, readwrite) NSUInteger followers;

@property (nonatomic, copy, readwrite) NSString *followers_url;

@property (nonatomic, assign, readwrite) NSUInteger following;

@property (nonatomic, copy, readwrite) NSString *following_url;

@property (nonatomic, copy, readwrite) NSString *gists_url;

@property (nonatomic, copy, readwrite) NSString *gravatar_id;

@property (nonatomic, copy, readwrite) NSString *hireable;

@property (nonatomic, copy, readwrite) NSString *html_url;

@property (nonatomic, assign, readwrite) NSUInteger userId;

@property (nonatomic, copy, readwrite) NSString *location;

@property (nonatomic, copy, readwrite) NSString *login;

@property (nonatomic, copy, readwrite) NSString *name;

@property (nonatomic, copy, readwrite) NSString *organizations_url;

@property (nonatomic, assign, readwrite) NSUInteger public_gists;

@property (nonatomic, assign, readwrite) NSUInteger public_repos;

@property (nonatomic, copy, readwrite) NSString *received_events_url;

@property (nonatomic, copy, readwrite) NSString *repos_url;

@property (nonatomic, assign, readwrite) BOOL site_admin;

@property (nonatomic, copy, readwrite) NSString *starred_url;

@property (nonatomic, copy, readwrite) NSString *subscriptions_url;

@property (nonatomic, copy, readwrite) NSString *type;

@property (nonatomic, copy, readwrite) NSString *updated_at;

@property (nonatomic, copy, readwrite) NSString *url;

@end

@implementation TYUserDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{
             @"userId" : @"id"
             };
}

@end
