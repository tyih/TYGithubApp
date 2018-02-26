//
//  TYNewsCell.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/26.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYNewsCell.h"

#import "TYNewsItemViewModel.h"

@interface TYNewsCell ()

@property (nonatomic, weak) UILabel *attrLabel;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, strong) TYNewsItemViewModel *viewModel;

@end

@implementation TYNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *attrLabel = [UILabel labelWithText:@"xxxxxx" frame:CGRectMake(10, 5, 100, 40) font:[UIFont systemFontOfSize:15.f] color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        self.attrLabel = attrLabel;
        [self.contentView addSubview:attrLabel];
        
        UILabel *timeLabel = [UILabel labelWithText:@"2000.1.14" frame:CGRectMake(120, 5, 60, 40) font:[UIFont systemFontOfSize:15.f] color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        self.timeLabel = timeLabel;
        [self.contentView addSubview:timeLabel];
        
        RAC(attrLabel, text) = RACObserve(self.viewModel, title);
        RAC(timeLabel, text) = RACObserve(self.viewModel, time);
    }
    return self;
}

- (void)bindViewModel:(TYNewsItemViewModel *)viewModel {
    
    self.viewModel = viewModel;
    // 处理其他
}

@end
