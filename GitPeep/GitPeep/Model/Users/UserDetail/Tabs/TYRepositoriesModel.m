//
//  TYRepositoriesModel.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/2.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYRepositoriesModel.h"

@interface TYRepositoriesModel ()

@property (nonatomic, copy, readwrite) NSString *name;

@property (nonatomic, assign, readwrite) NSUInteger stargazers_count;

@property (nonatomic, copy, readwrite) NSString *language;

@property (nonatomic, copy, readwrite) NSString *characterization;

@end

@implementation TYRepositoriesModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{
             @"characterization" : @"description"
             };
}

@end
