//
//  UIView+line.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/5.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "UIView+line.h"

@implementation UIView (line)

+ (UIView *)lineViewWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width color:(UIColor *)color {
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, TYLINE_HEIGHT)];
    line.backgroundColor = color;
    return line;
}

@end
