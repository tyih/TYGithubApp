//
//  TYUsersCell.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/28.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYUsersCell.h"

#import "TYUsersItemModel.h"

@interface TYUsersCell ()

@property (nonatomic, strong) TYUsersItemModel *model;

@property (nonatomic, assign) NSInteger row;

@property (nonatomic, weak) UIImageView *avatarImgView;

@end

@implementation TYUsersCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *rankLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
        rankLabel.textAlignment = NSTextAlignmentCenter;
        rankLabel.text = @"1";
        [self.contentView addSubview:rankLabel];
        
        UIImageView *avatarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(rankLabel.right+10, 10, 60, 60)];
        avatarImgView.layer.borderWidth = 0.5f;
        avatarImgView.layer.borderColor = [UIColor grayColor].CGColor;
        avatarImgView.layer.cornerRadius = 3.f;
        avatarImgView.layer.masksToBounds = YES;
        self.avatarImgView = avatarImgView;
        [self.contentView addSubview:avatarImgView];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatarImgView.right+10, 10, 150, 60)];
        nameLabel.text = @"xxxxxx xx";
        nameLabel.textColor = HexRGB(colorA1);
        nameLabel.font = PingFangFont(16.f);
        [self.contentView addSubview:nameLabel];
        
        RAC(rankLabel, text) = [RACObserve(self, row) map:^id(NSNumber *row) {
            return row.stringValue;
        }];
        
        RAC(nameLabel, text) = [RACObserve(self, model.login) map:^id(NSString *name) {
            return name;
        }];
    }
    return self;
}

- (void)setObj:(TYUsersItemModel *)model withIndexPath:(NSIndexPath *)indexPath {
    
    self.model = model;
    self.row = indexPath.row + 1;
    
    [self.avatarImgView sd_setImageWithURL:[NSURL URLWithString:model.avatar_url]];
}

@end
