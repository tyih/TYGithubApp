//
//  UILabel+category.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/6.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (category)

+ (instancetype)labelWithText:(NSString *)text frame:(CGRect)frame font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment;

@end
