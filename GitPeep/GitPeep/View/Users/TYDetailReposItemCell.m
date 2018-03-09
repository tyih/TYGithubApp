//
//  TYDetailReposItemCell.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/2.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYDetailReposItemCell.h"

#import "TYRepositoriesItemModel.h"

@interface TYDetailReposItemCell ()

@property (nonatomic, strong) TYRepositoriesItemModel *model;

@property (nonatomic, assign) NSInteger row;

@end

@implementation TYDetailReposItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *numLabel = [UILabel labelWithText:nil frame:CGRectMake(10, 10, 40, 20) font:SystemFont(15.f) color:HexRGB(colorA1) alignment:NSTextAlignmentCenter];
        [self.contentView addSubview:numLabel];
        
        UILabel *nameLabel = [UILabel labelWithText:nil frame:CGRectMake(numLabel.right+10, numLabel.top, 200, 20) font:BoldSystemFont(16.f) color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:nameLabel];
        
        UILabel *starsLabel = [UILabel labelWithText:nil frame:CGRectMake(nameLabel.right+10, nameLabel.top, 100, 20) font:SystemFont(15.f) color:HexRGB(colorA1) alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:starsLabel];
        
        UILabel *languageLabel = [UILabel labelWithText:nil frame:CGRectMake(nameLabel.left, nameLabel.bottom+10, 200, 20) font:SystemFont(15.f) color:[UIColor grayColor] alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:languageLabel];
        
        UILabel *detailLabel = [UILabel labelWithText:nil frame:CGRectMake(nameLabel.left, languageLabel.bottom+10, 250, 60) font:SystemFont(15.f) color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        detailLabel.numberOfLines = 0;
        [self.contentView addSubview:detailLabel];
        
        RAC(numLabel, text) = [RACObserve(self, row) map:^id(NSNumber *row) {
            return row.stringValue;
        }];
        
        RAC(nameLabel, text) = [RACObserve(self, model.name) map:^id(NSString *name) {
            return name;
        }];
        
        RAC(starsLabel, text) = [RACObserve(self, model.stargazers_count) map:^id(NSNumber *count) {
            return [NSString stringWithFormat:@"stars: %@", count];
        }];
        
        RAC(languageLabel, text) = [RACObserve(self, model.language) map:^id(NSString *language) {
            return [NSString stringWithFormat:@"language: %@", language == nil ? @"" : language];
        }];
        
        RAC(detailLabel, text) = [RACObserve(self, model.characterization) map:^id(NSString *characterization) {
            return characterization;
        }];
 
    }
    
    return self;
}

- (void)setObj:(TYRepositoriesItemModel *)model withIndexPath:(NSIndexPath *)indexPath {
    
    self.model = model;
    self.row = indexPath.row;
}

@end
