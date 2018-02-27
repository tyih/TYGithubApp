//
//  UILabel+text.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/6.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "UILabel+text.h"

@implementation UILabel (text)

+ (instancetype)labelWithText:(NSString *)text frame:(CGRect)frame font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = alignment;
    label.text = text;
    label.font = font;
    label.textColor = color;
    return label;
}

@end
