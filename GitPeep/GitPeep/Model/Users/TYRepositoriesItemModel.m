//
//  TYRepositoriesItemModel.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/2.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYRepositoriesItemModel.h"

@interface TYRepositoriesItemModel ()

@property (nonatomic, copy, readwrite) NSString *name;

@property (nonatomic, copy, readwrite) NSString *full_name;

@property (nonatomic, assign, readwrite) NSUInteger stargazers_count;

@property (nonatomic, copy, readwrite) NSString *language;

@property (nonatomic, copy, readwrite) NSString *characterization;

@property (nonatomic, copy, readwrite) NSString *created_at;

@property (nonatomic, copy, readwrite) NSString *homepage;

@property (nonatomic, assign, readwrite) NSUInteger forks_count;

@property (nonatomic, strong, readwrite) TYUsersItemModel *owner;

@end

@implementation TYRepositoriesItemModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{
             @"characterization" : @"description"
             };
}

@end
