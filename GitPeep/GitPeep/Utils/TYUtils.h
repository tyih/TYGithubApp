//
//  NSObject+TYUtils.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/23.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TYUtils)

/// Judging the string
///
/// return YES or NO.
- (BOOL)isExist;
- (BOOL)isImage;
- (BOOL)isMarkdown;

@end

@interface UIColor (TYUtils)

/// Generating a new image by the color.
///
/// Return a new image.
- (UIImage *)color2Image;
- (UIImage *)color2ImageSized:(CGSize)size;

@end
