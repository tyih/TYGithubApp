//
//  TYProfileCell.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/9.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYProfileCell.h"

@interface TYProfileCell ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIImageView *arrowView;

@end

@implementation TYProfileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 34, 34)];
        iconView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        UILabel *titleLabel = [UILabel labelWithText:nil frame:CGRectMake(iconView.right+10, 0, 250, 44) font:PingFangFont(18.f) color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-24, 10, 24, 24)];
        arrowView.image = [UIImage imageNamed:@"right_arrow_icon"];
        [self.contentView addSubview:arrowView];
        self.arrowView = arrowView;
    }
    return self;
}

- (void)setObj:(NSString *)title withIndexPath:(NSIndexPath *)indexPath {
    
    if (title.length == 0) {
        self.titleLabel.textColor = [UIColor lightGrayColor];
    }
    self.titleLabel.text = title.length == 0 ? @"Not Set" : title;
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
                self.iconView.image = [UIImage octicon_imageWithIcon:@"Organization" backgroundColor:[UIColor clearColor] iconColor:HexRGB(0x24AFFC) iconScale:1.f andSize:CGSizeMake(25, 25)];
                self.arrowView.hidden = YES;
                break;
            case 1:
                self.iconView.image = [UIImage octicon_imageWithIcon:@"Location" backgroundColor:[UIColor clearColor] iconColor:HexRGB(0x30C931) iconScale:1.f andSize:CGSizeMake(25, 25)];
                self.arrowView.hidden = YES;
                break;
            case 2:
                self.iconView.image = [UIImage octicon_imageWithIcon:@"Mail" backgroundColor:[UIColor clearColor] iconColor:HexRGB(0x5586ED) iconScale:1.f andSize:CGSizeMake(25, 25)];
                if (title.length == 0) {
                    self.arrowView.hidden = YES;
                } else {
                    self.arrowView.hidden = NO;
                }
                break;
            case 3:
                self.iconView.image = [UIImage octicon_imageWithIcon:@"Link" backgroundColor:[UIColor clearColor] iconColor:HexRGB(0x90DD2F) iconScale:1.f andSize:CGSizeMake(25, 25)];
                if (title.length == 0) {
                    self.arrowView.hidden = YES;
                } else {
                    self.arrowView.hidden = NO;
                }
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        
        self.iconView.image = [UIImage octicon_imageWithIcon:@"Gear" backgroundColor:[UIColor clearColor] iconColor:HexRGB(0x24AFFC) iconScale:1.f andSize:CGSizeMake(25, 25)];
        self.arrowView.hidden = NO;
    }
}

@end
