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
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:HexRGB(colorA5) forState:UIControlStateDisabled];
    
    [self setBackgroundImage:[HexRGB(colorA4) color2Image] forState:UIControlStateNormal];
    [self setBackgroundImage:[HexRGB(colorA6) color2Image] forState:UIControlStateDisabled];
    
    
    return self;
}

@end
