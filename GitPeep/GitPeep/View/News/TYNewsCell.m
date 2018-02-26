//
//  TYNewsCell.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/26.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYNewsCell.h"

@interface TYNewsCell ()

@property (nonatomic, weak) UILabel *attrLabel;

@property (nonatomic, weak) UILabel *timeLabel;

@end

@implementation TYNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *attrLabel = [UILabel labelWithText:@"xxxxxx" frame:CGRectMake(10, 5, 100, 40) font:[UIFont systemFontOfSize:15.f] color:[UIColor blueColor] alignment:NSTextAlignmentLeft];
        self.attrLabel = attrLabel;
        [self.contentView addSubview:attrLabel];
        
        UILabel *timeLabel = [UILabel labelWithText:@"2000.1.14" frame:CGRectMake(120, 5, 60, 40) font:[UIFont systemFontOfSize:15.f] color:[UIColor blueColor] alignment:NSTextAlignmentLeft];
        self.timeLabel = timeLabel;
        [self.contentView addSubview:timeLabel];
        
//        RAC(attrLabel, text) = RACObserve(self.model, title);
//        RAC(timeLabel, text) = RACObserve(self.model, time);
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
