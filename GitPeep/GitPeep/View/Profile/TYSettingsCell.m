//
//  TYSettingsCell.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/9.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYSettingsCell.h"

@interface TYSettingsCell ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *desLabel;

@property (nonatomic, weak) UIImageView *arrowView;

@property (nonatomic, weak) UILabel *centerLabel;

@end

@implementation TYSettingsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *titleLabel = [UILabel labelWithText:nil frame:CGRectMake(15, 0, 120, 44) font:PingFangFont(18.f) color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *desLabel = [UILabel labelWithText:nil frame:CGRectMake(SCREEN_WIDTH-44-150, 0, 150, 44) font:PingFangFont(16.f) color:[UIColor grayColor] alignment:NSTextAlignmentCenter];
        [self.contentView addSubview:desLabel];
        self.desLabel = desLabel;
        
        UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-24, 10, 24, 24)];
        arrowView.image = [UIImage imageNamed:@"right_arrow_icon"];
        [self.contentView addSubview:arrowView];
        self.arrowView = arrowView;
        
        UILabel *centerLabel = [UILabel labelWithText:nil frame:CGRectMake(0, 0, SCREEN_WIDTH, 44) font:PingFangFont(18.f) color:[UIColor blackColor] alignment:NSTextAlignmentCenter];
        [self.contentView addSubview:centerLabel];
        self.centerLabel = centerLabel;
    }
    return self;
}

- (void)setObj:(id)obj withIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            self.titleLabel.text = (NSString *)obj;
            self.desLabel.text = [SAMKeychain rawLogin];
            break;
        case 1:
            self.titleLabel.text = (NSString *)obj;
            break;
        case 2:
            self.centerLabel.text = (NSString *)obj;
            self.arrowView.hidden = YES;
            break;
            
        default:
            break;
    }
}

@end
