//
//  UIImage+TYOcticons.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/5.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "UIImage+TYOcticons.h"

@implementation UIImage (TYOcticons)

+ (UIImage *)octicon_ImageWithIcon:(NSString *)icon size:(CGSize)size {
    
    return [UIImage octicon_imageWithIcon:icon
                          backgroundColor:[UIColor clearColor]
                                iconColor:[UIColor blackColor]
                                iconScale:1.f
                                  andSize:size];
}

@end
