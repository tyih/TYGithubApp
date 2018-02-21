//
//  TYButton.m
//  GitPeep
//
//  Created by tiany on 2018/2/10.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYButton.h"

@implementation TYButton

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initialize {
    
    self.layer.cornerRadius = 3.f;
    self.layer.masksToBounds = YES;
    
    [self setBackgroundImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>]
}

@end
