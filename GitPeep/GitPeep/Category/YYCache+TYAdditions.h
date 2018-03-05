//
//  YYCache+TYAdditions.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/5.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <YYCache/YYCache.h>

extern NSString * const TYTrendingReposLanguageCacheKey;
extern NSString * const TYPopularReposLanguageCacheKey;
extern NSString * const TYPopularUsersReposCacheKey;

@interface YYCache (TYAdditions)

+ (instancetype)sharedCache;

@end
