//
//  TYTabButtonsView.m
//  GitPeep
//
//  Created by tiany on 2018/3/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYTabButtonsView.h"

@interface TYTabButtonsView ()

@property (nonatomic, weak) UIButton *preButton;

@property (nonatomic, assign, readwrite) TYTabButtonsType chooseType;

@end

@implementation TYTabButtonsView

- (instancetype)initWithTitlesFirst:(NSString *)first second:(NSString *)second third:(NSString *)third frame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat itemW = SCREEN_WIDTH / 3;
        CGFloat itemH = 60;
        
        UIButton *firstButton = [self buttonWithTitle:first number:0 rect:CGRectMake(0, 0, itemW, itemH)];
        firstButton.tag = TYTabButtonsTypeFirst;
        [self addSubview:firstButton];
        self.firstLabel = [firstButton viewWithTag:100];
        
        UIButton *secondButton = [self buttonWithTitle:second number:0 rect:CGRectMake(itemW, 0, itemW, itemH)];
        secondButton.tag = TYTabButtonsTypeSecond;
        [self addSubview:secondButton];
        self.secondLabel = [secondButton viewWithTag:100];
        
        UIButton *thirdButton = [self buttonWithTitle:third number:0 rect:CGRectMake(itemW*2, 0, itemW, itemH)];
        thirdButton.tag = TYTabButtonsTypeThird;
        [self addSubview:thirdButton];
        self.thirdLabel = [thirdButton viewWithTag:100];
        
        // 默认选中 repoButton
        firstButton.selected = YES;
        self.preButton = firstButton;
        [self setButtonItemsColor:firstButton];
        self.chooseType = TYTabButtonsTypeFirst;
    }
    return self;
}

- (UIButton *)buttonWithTitle:(NSString *)title number:(NSInteger)number rect:(CGRect)rect {
    
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    UILabel *numLabel = [UILabel labelWithText:[NSString stringWithFormat:@"%ld", number] frame:CGRectMake(0, 0, rect.size.width, rect.size.height*0.5) font:BoldSystemFont(15.f) color:[UIColor blackColor] alignment:NSTextAlignmentCenter];
    numLabel.tag = 100;
    UILabel *nameLabel = [UILabel labelWithText:title frame:CGRectMake(0, numLabel.bottom, rect.size.width, rect.size.height*0.5) font:BoldSystemFont(15.f) color:[UIColor blackColor] alignment:NSTextAlignmentCenter];
    nameLabel.tag = 101;
    [button addSubview:numLabel];
    [button addSubview:nameLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(30, button.height-3, rect.size.width-60, 3)];
    line.backgroundColor = HexRGB(colorA7);
    line.tag = 102;
    line.hidden = YES;
    [button addSubview:line];
    
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        @strongify(self);
        self.preButton.selected = NO;
        [self setButtonItemsColor:self.preButton];
        
        button.selected = YES;
        [self setButtonItemsColor:button];
        
        self.preButton = button;
        
        TYTabButtonsType chooseType = button.tag;
        self.chooseType = chooseType;
    }];
    
    return button;
}

- (void)setButtonItemsColor:(UIButton *)button {
    
    UILabel *numLabel = [button viewWithTag:100];
    UILabel *nameLabel = [button viewWithTag:101];
    UIView *line = [button viewWithTag:102];
    
    if (button.selected) {
        
        numLabel.textColor = HexRGB(colorA7);
        nameLabel.textColor = HexRGB(colorA7);
        line.hidden = NO;
    } else {
        
        numLabel.textColor = [UIColor blackColor];
        nameLabel.textColor = [UIColor blackColor];
        line.hidden = YES;
    }
}

@end
