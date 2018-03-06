//
//  TYExploreItemCell.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/5.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYExploreItemCell.h"

#import "TYExploreCollectionViewCell.h"
#import "TYExploreItemCellViewModel.h"

@interface TYExploreItemCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) TYExploreItemCellViewModel *viewModel;

@property (nonatomic, weak) UIButton *seeAllButton;

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation TYExploreItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *titleLabel = [UILabel labelWithText:nil frame:CGRectMake(10, 5, 200, 20) font:SystemFont(15.f) color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:titleLabel];
        
        UIButton *seeAllButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-80, 5, 80, 20)];
        [self.contentView addSubview:seeAllButton];

        UILabel *seeAllLabel = [UILabel labelWithText:@"see All" frame:CGRectMake(0, 0, 50, 20) font:SystemFont(13.f) color:[UIColor grayColor] alignment:NSTextAlignmentRight];
        [seeAllButton addSubview:seeAllLabel];
        
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, 30, 20)];
        arrowImgView.image = [UIImage imageNamed:@"right_arrow_icon"];
        [seeAllButton addSubview:arrowImgView];
        self.seeAllButton = seeAllButton;
        
        [self.contentView addSubview:seeAllButton];

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake(80, 110);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, titleLabel.bottom, SCREEN_WIDTH-20, 138) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[TYExploreCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
        [self.contentView addSubview:collectionView];
        self.collectionView = collectionView;
        
        RAC(titleLabel, text) = [RACObserve(self, viewModel.title) map:^id(NSString *title) {
            return title;
        }];

    }
    return self;
}

- (void)bindViewModel:(TYExploreItemCellViewModel *)viewModel {
    
    self.viewModel = viewModel;
    
    self.seeAllButton.rac_command = self.viewModel.seeAllCommand;
    
    [self.collectionView reloadData];
}

#pragma mark - collectionView

// 多少section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

// section对应多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

// item显示内容
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TYExploreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    TYExploreCollectionViewCellViewModel *viewModel = (TYExploreCollectionViewCellViewModel *)self.viewModel.collectionCellViewModels[indexPath.row];
    [cell bindViewModel:viewModel];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TYExploreCollectionViewCellViewModel *viewModel = (TYExploreCollectionViewCellViewModel *)self.viewModel.collectionCellViewModels[indexPath.row];
    [viewModel.didSelectCommand execute:viewModel];
}

@end
