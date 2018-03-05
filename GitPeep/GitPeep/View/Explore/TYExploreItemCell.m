//
//  TYExploreItemCell.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/5.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYExploreItemCell.h"

@implementation TYExploreItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *titleLabel = [UILabel labelWithText:nil frame:CGRectMake(10, 5, 200, 20) font:SystemFont(13.f) color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:titleLabel];
        
        UIButton *seeButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-80, 5, 80, 20)];
        [self.contentView addSubview:seeButton];
        
        UICollectionView *collectionView = [UICollectionView alloc] initWithFrame:<#(CGRect)#> collectionViewLayout:<#(nonnull UICollectionViewLayout *)#>
    }
    return self;
}

- (void)setModel:(id)model withIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
