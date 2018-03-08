//
//  TYExploreCollectionViewCell.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/6.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYExploreCollectionViewCell.h"

#import "TYExploreCollectionViewCellViewModel.h"

@interface TYExploreCollectionViewCell ()

@property (nonatomic, strong) TYExploreCollectionViewCellViewModel *viewModel;

@end

@implementation TYExploreCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *avatarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        avatarImgView.backgroundColor = [UIColor lightGrayColor];
        avatarImgView.layer.cornerRadius = 20.f;
        avatarImgView.layer.masksToBounds = YES;
        [self.contentView addSubview:avatarImgView];
        
        UILabel *nameLabel = [UILabel labelWithText:nil frame:CGRectMake(0, 80, 80, 30) font:SystemFont(11.f) color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        nameLabel.numberOfLines = 0;
        [self.contentView addSubview:nameLabel];
        
        [RACObserve(self, viewModel.avatarUrl) subscribeNext:^(NSString *avatarUrl) {
            
            [avatarImgView sd_setImageWithURL:[NSURL URLWithString:avatarUrl]];
        }];
        
        RAC(nameLabel, text) = [RACObserve(self, viewModel.name) map:^id(NSString *name) {
            
            return name;
        }];
    }
    return self;
}

- (void)bindViewModel:(id)viewModel {
    
    self.viewModel = viewModel;
}

@end
