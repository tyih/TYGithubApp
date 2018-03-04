//
//  TYRepositoriesItemCell.m
//  GitPeep
//
//  Created by tiany on 2018/3/3.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYRepositoriesItemCell.h"

#import "TYRepositoriesItemModel.h"

@interface TYRepositoriesItemCell ()

@property (nonatomic, strong) TYRepositoriesItemModel *model;

@property (nonatomic, assign) NSUInteger row;

@property (nonatomic, weak) UIImageView *logoImgView;

@end

@implementation TYRepositoriesItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *numLabel = [UILabel labelWithText:@"1" frame:CGRectMake(10, 5, 50, 50) font:SystemFont(14.f) color:HexRGB(colorA1) alignment:NSTextAlignmentCenter];
        [self.contentView addSubview:numLabel];
        
        UILabel *nameLabel = [UILabel labelWithText:@"Javascript" frame:CGRectMake(numLabel.right+5, numLabel.top, 200, 20) font:SystemFont(18.f) color:HexRGB(colorA1) alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:nameLabel];
        
        UILabel *starsLabel = [UILabel labelWithText:@"Star: 99999" frame:CGRectMake(nameLabel.right, nameLabel.top, 100, 20) font:SystemFont(13.f) color:HexRGB(colorA1) alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:starsLabel];
        
        UILabel *ownerLabel = [UILabel labelWithText:@"Owner: facebook" frame:CGRectMake(nameLabel.left, nameLabel.bottom+5, 150, 20) font:SystemFont(14.f) color:HexRGB(colorA1) alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:ownerLabel];
        
        UILabel *linkLabel = [UILabel labelWithText:@"https://reactjs.org" frame:CGRectMake(ownerLabel.right+5, ownerLabel.top, 150, 20) font:SystemFont(13.f) color:HexRGB(colorA1) alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:linkLabel];
        
        UILabel *descriptionLabel = [UILabel labelWithText:@"xxxxxx yyyyyy xxxxxx yyyyyy xxxxxx yyyyyy xxxxxx yyyyyy xxxxxx yyyyyy" frame:CGRectMake(ownerLabel.left, numLabel.bottom, 250, 80) font:SystemFont(14.f) color:HexRGB(colorA1) alignment:NSTextAlignmentLeft];
        descriptionLabel.numberOfLines = 0;
        [self.contentView addSubview:descriptionLabel];
        
        UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(numLabel.left, numLabel.bottom, numLabel.width, numLabel.width)];
        logoImgView.layer.borderWidth = 0.2f;
        logoImgView.layer.borderColor = [UIColor grayColor].CGColor;
        logoImgView.layer.cornerRadius = 3.f;
        logoImgView.layer.masksToBounds = YES;
        [self.contentView addSubview:logoImgView];
        self.logoImgView = logoImgView;
        
        RAC(numLabel, text) = [RACObserve(self, row) map:^id(NSNumber *number) {
            return number.stringValue;
        }];
        
        RAC(nameLabel, text) = [RACObserve(self, model.name) map:^id(NSString *name) {
            return name;
        }];
        
        RAC(starsLabel, text) = [RACObserve(self, model.stargazers_count) map:^id(NSNumber *count) {
            return [NSString stringWithFormat:@"Stars: %@", count];
        }];
        
        RAC(ownerLabel, text) = [RACObserve(self, model.owner.login) map:^id(NSString *login) {
            return [NSString stringWithFormat:@"Owner: %@", login];
        }];
        
        RAC(linkLabel, text) = [RACObserve(self, model.homepage) map:^id(NSString *homepage) {
            return homepage;
        }];
        
        RAC(descriptionLabel, text) = [RACObserve(self, model.characterization) map:^id(NSString *characterization) {
            return characterization;
        }];
    }
    return self;
}

- (void)setModel:(TYRepositoriesItemModel *)model withIndexPath:(NSIndexPath *)indexPath {
    
    self.model = model;
    self.row = indexPath.row + 1;
    [self.logoImgView sd_setImageWithURL:[NSURL URLWithString:model.owner.avatar_url]];
    
}

@end
