//
//  TYUsersCell.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/28.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYUsersCell.h"

#import "TYUsersItemViewModel.h"

@interface TYUsersCell ()

@property (nonatomic, strong) TYUsersItemViewModel *viewModel;

@end

@implementation TYUsersCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *rankLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
        rankLabel.backgroundColor = [UIColor yellowColor];
        rankLabel.textAlignment = NSTextAlignmentCenter;
        rankLabel.text = @"1";
        [self.contentView addSubview:rankLabel];
        
        UIImageView *avatarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(rankLabel.right+10, 10, 60, 60)];
        avatarImgView.backgroundColor = [UIColor redColor];
        avatarImgView.layer.cornerRadius = 3.f;
        avatarImgView.layer.masksToBounds = YES;
        [self.contentView addSubview:avatarImgView];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatarImgView.right+10, 10, 100, 60)];
        nameLabel.backgroundColor = [UIColor blueColor];
        nameLabel.text = @"xxxxxx xx";
        [self.contentView addSubview:nameLabel];
    }
    return self;
}

- (void)bindViewModel:(id)viewModel {
    
    self.viewModel = viewModel;
}

@end
