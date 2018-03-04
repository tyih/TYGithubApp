//
//  TYTabButtonsView.h
//  GitPeep
//
//  Created by tiany on 2018/3/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYTabButtonsView : UIView

@property (nonatomic, assign, readonly) TYTabButtonsType chooseType;

@property (nonatomic, weak) UILabel *firstLabel;

@property (nonatomic, weak) UILabel *secondLabel;

@property (nonatomic, weak) UILabel *thirdLabel;

- (instancetype)initWithTitlesFirst:(NSString *)first second:(NSString *)second third:(NSString *)third frame:(CGRect)frame;

@end
