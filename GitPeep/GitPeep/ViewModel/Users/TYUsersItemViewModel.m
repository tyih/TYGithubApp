//
//  TYUsersItemViewModel.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/28.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYUsersItemViewModel.h"

@interface TYUsersItemViewModel ()

@end

@implementation TYUsersItemViewModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        TYUsersItemModel *model = [TYUsersItemModel yy_modelWithDictionary:dictionary];
        self.model = model;
    }
    return self;
}

@end
