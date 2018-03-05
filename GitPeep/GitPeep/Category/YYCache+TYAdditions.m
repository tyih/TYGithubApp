//
//  YYCache+TYAdditions.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/5.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "YYCache+TYAdditions.h"

NSString * const TYTrendingReposLanguageCacheKey = @"TYTrendingReposLanguageCacheKey";
NSString * const TYPopularReposLanguageCacheKey = @"TYPopularReposLanguageCacheKey";
NSString * const TYPopularUsersReposCacheKey = @"TYPopularUsersReposCacheKey";

@implementation YYCache (TYAdditions)

+ (instancetype)sharedCache {
    
    static YYCache *sharedCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCache = [YYCache cacheWithName:@"Explore"];
    });
    return sharedCache;
}

@end
