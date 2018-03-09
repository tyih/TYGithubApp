//
//  TYUserDetailModel.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/1.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYUserDetailModel : NSObject

@property (nonatomic, copy, readonly) NSString *avatar_url;

@property (nonatomic, copy, readonly) NSString *bio;

@property (nonatomic, copy, readonly) NSString *blog;

@property (nonatomic, copy, readonly) NSString *company;

@property (nonatomic, copy, readonly) NSString *created_at;

@property (nonatomic, copy, readonly) NSString *email;

@property (nonatomic, copy, readonly) NSString *events_url;

@property (nonatomic, assign, readonly) NSUInteger followers;

@property (nonatomic, copy, readonly) NSString *followers_url;

@property (nonatomic, assign, readonly) NSUInteger following;

@property (nonatomic, copy, readonly) NSString *following_url;

@property (nonatomic, copy, readonly) NSString *gists_url;

@property (nonatomic, copy, readonly) NSString *gravatar_id;

@property (nonatomic, copy, readonly) NSString *hireable;

@property (nonatomic, copy, readonly) NSString *html_url;

@property (nonatomic, assign, readonly) NSUInteger userId;

@property (nonatomic, copy, readonly) NSString *location;

@property (nonatomic, copy, readonly) NSString *login;

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, copy, readonly) NSString *organizations_url;

@property (nonatomic, assign, readonly) NSUInteger public_gists;

@property (nonatomic, assign, readonly) NSUInteger public_repos;

@property (nonatomic, copy, readonly) NSString *received_events_url;

@property (nonatomic, copy, readonly) NSString *repos_url;

@property (nonatomic, assign, readonly) BOOL site_admin;

@property (nonatomic, copy, readonly) NSString *starred_url;

@property (nonatomic, copy, readonly) NSString *subscriptions_url;

@property (nonatomic, copy, readonly) NSString *type;

@property (nonatomic, copy, readonly) NSString *updated_at;

@property (nonatomic, copy, readonly) NSString *url;

@end
