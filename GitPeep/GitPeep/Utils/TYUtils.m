//
//  NSObject+TYUtils.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/23.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYUtils.h"

@implementation NSString (TYUtils)

- (BOOL)isExist {
    
    return self && ![self isEqualToString:@""];
}

- (BOOL)isImage {
    
    if (!self.isExist) {
        return NO;
    }
    
    NSArray *imageExtensions = @[@".png", @".gif", @".jpg", @".jpeg"];
    for (NSString *extension in imageExtensions) {
        if ([self.lowercaseString hasSuffix:extension]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isMarkdown {
    
    if (!self.isExist) {
        return NO;
    }
    
    NSArray *markdownExtensions = @[@".md", @".mkdn", @".mdwn", @".mdown", @".markdown", @".mkd", @".mkdown", @".ron"];
    for (NSString *extension in markdownExtensions) {
        if ([self.lowercaseString hasSuffix:extension]) {
            return YES;
        }
    }
    return NO;
}

@end

@implementation UIColor (TYUtils)

- (UIImage *)color2Image {
    
    return [self color2ImageSized:CGSizeMake(1.f, 1.f)];
}

- (UIImage *)color2ImageSized:(CGSize)size {
    
    CGRect rect = CGRectMake(0.f, 0.f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
