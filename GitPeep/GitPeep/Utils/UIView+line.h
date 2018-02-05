//
//  UIView+line.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/5.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TYLINE_HEIGHT 1.f

@interface UIView (line)

+ (UIView *)lineViewWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width color:(UIColor *)color;

@end
