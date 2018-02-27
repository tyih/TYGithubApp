//
//  UIView+frame.m
//  Solarman
//
//  Created by IGEN-TECH on 2017/1/18.
//  Copyright © 2017年 IGEN-TECH. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)

#pragma mark - getter

- (CGFloat)x {
    return CGRectGetMinX(self.frame);
}

- (CGFloat)y {
    return CGRectGetMinY(self.frame);
}

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (CGFloat)centerX {
    return self.center.x;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (CGSize)size {
    return self.frame.size;
}

- (CGFloat)top {
    return CGRectGetMinY(self.frame);
}

- (CGFloat)left {
    return CGRectGetMinX(self.frame);
}

- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)right {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)midX {
    return CGRectGetMidX(self.frame);
}

- (CGFloat)midY {
    return CGRectGetMidY(self.frame);
}

#pragma mark - setter

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setTop:(CGFloat)top {
    [self setY:top];
}

- (void)setLeft:(CGFloat)left {
    [self setX:left];
}

- (void)setBottom:(CGFloat)bottom {
    self.y = bottom - self.height;
}

- (void)setRight:(CGFloat)right {
    self.x = right - self.width;
}

- (void)setMidX:(CGFloat)midX {
    self.x = midX - self.width * 0.5;
}

- (void)setMidY:(CGFloat)midY {
    self.y = midY - self.height * 0.5;
}

@end
