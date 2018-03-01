//
//  TYUsersItemViewModel.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/28.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TYUsersItemModel.h"

@interface TYUsersItemViewModel : NSObject

@property (nonatomic, strong) TYUsersItemModel *model;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
