//
//  TYNewsItemViewModel.m
//  GitPeep
//
//  Created by tiany on 2018/2/26.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYNewsItemViewModel.h"

@interface TYNewsItemViewModel ()

@property (nonatomic, copy, readwrite) NSString *title;

@property (nonatomic, copy, readwrite) NSString *time;

@end

@implementation TYNewsItemViewModel

- (instancetype)initWithTitle:(NSString *)title time:(NSString *)time {
    
    self = [super init];
    if (self) {
        self.title = title;
        self.time = time;
    }
    return self;
}

@end
