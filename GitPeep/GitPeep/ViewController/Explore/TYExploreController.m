//
//  TYExploreController.m
//  GitPeep
//
//  Created by tiany on 2018/1/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYExploreController.h"

#import "TYExploreItemCell.h"
#import "TYExploreItemCellViewModel.h"
#import "TYExploreCycleViewCell.h"

@interface TYExploreController () <TYCyclePagerViewDelegate, TYCyclePagerViewDataSource> {
    
    TYCyclePagerView *_pagerView;
    TYPageControl *_pageControl;
    NSArray *_datas;
}

@end

@implementation TYExploreController

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _pagerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
    _pageControl.frame = CGRectMake(0, _pagerView.height-26, _pagerView.width, 26);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addPageView];
    [self addPageControl];
    self.tableView.tableHeaderView = _pagerView;
    [self loadData];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

#pragma mark - page view

- (void)addPageView {
    
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc] init];
    pagerView.layer.borderWidth = 0.2f;
    pagerView.isInfiniteLoop = YES;
    pagerView.autoScrollInterval = 3.f;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    [pagerView registerClass:[TYExploreCycleViewCell class] forCellWithReuseIdentifier:@"cellId"];
    _pagerView = pagerView;
}

- (void)addPageControl {
    
    TYPageControl *pageControl = [[TYPageControl alloc] init];
    pageControl.currentPageIndicatorSize = CGSizeMake(8, 8);
    [_pagerView addSubview:pageControl];
    _pageControl = pageControl;
}

- (void)loadData {
    
    NSMutableArray *datas = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        [datas addObject:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:0.3f]];
    }
    _datas = [datas copy];
    _pageControl.numberOfPages = _datas.count;
    [_pagerView reloadData];
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return _datas.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    TYExploreCycleViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    cell.backgroundColor = _datas[index];
    NSString *title = nil;
    switch (index) {
        case 0:
            title = @"Package";
            break;
        case 1:
            title = @"Ember";
            break;
        case 2:
            title = @"Emoji";
            break;
        case 3:
            title = @"Security";
            break;
        case 4:
            title = @"Universal";
            break;
            
        default:
            break;
    }
    cell.label.text = title;
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame), CGRectGetHeight(pageView.frame));
//    layout.itemSpacing = 15;
    //layout.minimumAlpha = 0.3;
    layout.itemHorizontalCenter = YES;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

#pragma mark - tableview

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    
    TYExploreItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExploreCell"];
    if (cell == nil) {
        cell = [[TYExploreItemCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ExploreCell"];
    }
    return cell;
}

- (void)configureCell:(TYExploreItemCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(TYExploreItemCellViewModel *)viewModel {
    
    [cell bindViewModel:viewModel];
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 168;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
