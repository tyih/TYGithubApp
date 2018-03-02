//
//  TYRepositoriesModel.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/2.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYRepositoriesModel : NSObject

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, assign, readonly) NSUInteger stargazers_count;

@property (nonatomic, copy, readonly) NSString *language;

@property (nonatomic, copy, readonly) NSString *characterization;

@end
