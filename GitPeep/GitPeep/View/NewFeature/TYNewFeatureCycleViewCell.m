//
//  TYNewFeatureCycleViewCell.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/13.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYNewFeatureCycleViewCell.h"

@interface TYNewFeatureCycleViewCell ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak, readwrite) UILabel *titleLabel;

@end

@implementation TYNewFeatureCycleViewCell

- (void)setImage:(UIImage *)image {
    
    _image = image;
    
    self.iconView.image = image;
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
    }
    return self;
}

@end
