//
//  TYRepositoriesItemModel.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/2.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TYUsersItemModel.h"

@interface TYRepositoriesItemModel : NSObject

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, copy, readonly) NSString *full_name;

@property (nonatomic, assign, readonly) NSUInteger stargazers_count;

@property (nonatomic, copy, readonly) NSString *language;

@property (nonatomic, copy, readonly) NSString *characterization;

@property (nonatomic, copy, readonly) NSString *created_at;

@property (nonatomic, copy, readonly) NSString *homepage;

@property (nonatomic, assign, readonly) NSUInteger forks_count;

@property (nonatomic, strong, readonly) TYUsersItemModel *owner;

@end
