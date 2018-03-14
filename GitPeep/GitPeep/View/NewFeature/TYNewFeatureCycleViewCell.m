//
//  TYNewFeatureCycleViewCell.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/13.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYNewFeatureCycleViewCell.h"

#import "FBShimmeringView.h"

@interface TYNewFeatureCycleViewCell ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) FBShimmeringView *shimmeringView;

@property (nonatomic, weak) UILabel *shimmerLabel;

@end

@implementation TYNewFeatureCycleViewCell

- (void)setImage:(UIImage *)image {
    
    _image = image;
    
    self.iconView.image = image;
}

- (void)setShimmeringViewHidden:(BOOL)hidden {

    self.shimmeringView.hidden = hidden;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-50)*0.5, (self.height-50)*0.5, 50, 50)];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, iconView.bottom, self.width, 60)];
        titleLabel.font = PingFangFont(20.f);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(0, titleLabel.bottom, self.width, 60)];
        shimmeringView.shimmering = YES;
        shimmeringView.shimmeringOpacity = 0.2;
        shimmeringView.shimmeringBeginFadeDuration = 0.5;
        shimmeringView.shimmeringSpeed = 200;
        shimmeringView.shimmeringAnimationOpacity = 1.0;
        
        UILabel *shimmerLabel = [UILabel labelWithText:@"Swipe left to login" frame:shimmeringView.bounds font:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:40.0] color:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
        shimmeringView.contentView = shimmerLabel;
        
        [self addSubview:shimmeringView];
        self.shimmeringView = shimmeringView;
    }
    return self;
}

@end
