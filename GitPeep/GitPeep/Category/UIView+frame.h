//
//  UIView+frame.h
//  Solarman
//
//  Created by IGEN-TECH on 2017/1/18.
//  Copyright © 2017年 IGEN-TECH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frame)

@property(nonatomic, assign) CGFloat x;

@property(nonatomic, assign) CGFloat y;

@property(nonatomic, assign) CGFloat width;

@property(nonatomic, assign) CGFloat height;

@property(nonatomic, assign) CGFloat centerX;

@property(nonatomic, assign) CGFloat centerY;

@property(nonatomic, assign) CGSize size;

@property(nonatomic, assign) CGFloat top;   // 上

@property(nonatomic, assign) CGFloat left;  // 左

@property(nonatomic, assign) CGFloat bottom;// 下

@property(nonatomic, assign) CGFloat right; // 右

@property (nonatomic, assign) CGFloat midX;

@property (nonatomic, assign) CGFloat midY;

@end
