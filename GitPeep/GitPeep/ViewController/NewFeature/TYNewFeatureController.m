//
//  TYNewFeatureController.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/22.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYNewFeatureController.h"

#import "TYNewFeatureCycleViewCell.h"
#import "TYNewFeatureViewModel.h"

@interface TYNewFeatureController () <TYCyclePagerViewDelegate, TYCyclePagerViewDataSource> {
    
    TYCyclePagerView *_pagerView;
    TYPageControl *_pageControl;
    NSArray *_datas;
}

@property (nonatomic, weak) TYNewFeatureViewModel *viewModel;

@end

@implementation TYNewFeatureController

@dynamic viewModel;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _pagerView.frame = CGRectMake(0, -10, SCREEN_WIDTH, SCREEN_HEIGHT+10);
    _pageControl.frame = CGRectMake(0, _pagerView.height-26, _pagerView.width, 26);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addPageView];
    [self addPageControl];
    
    [self.view addSubview:_pagerView];
    
    [self loadData];
}

#pragma mark - page view

- (void)addPageView {
    
    TYCyclePagerView *pageView = [[TYCyclePagerView alloc] init];
    pageView.layer.borderWidth = 0.2f;
    pageView.isInfiniteLoop = NO;
//    pageView.autoScrollInterval = 3.f;
    pageView.dataSource = self;
    pageView.delegate = self;
    [pageView registerClass:[TYNewFeatureCycleViewCell class] forCellWithReuseIdentifier:@"cellId"];
    _pagerView = pageView;
}

- (void)addPageControl {
    
    TYPageControl *pageControl = [[TYPageControl alloc] init];
    pageControl.currentPageIndicatorSize = CGSizeMake(8, 8);
    [_pagerView addSubview:pageControl];
    _pageControl = pageControl;
}

- (void)loadData {
    
    NSMutableArray *datas = [NSMutableArray array];
    [datas addObject:HexRGB(0x432A46)];
    [datas addObject:HexRGB(0x293A86)];
    [datas addObject:HexRGB(0x50A96A)];
    _datas = [datas copy];
    _pageControl.numberOfPages = _datas.count;
    [_pagerView reloadData];
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return _datas.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    
    TYNewFeatureCycleViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    NSLog(@"%p", cell)
    NSString *title = nil;
    NSString *icon = nil;
    UIColor *iconColor;
    switch (index) {
        case 0:
            title = @"Write better code";
            icon = @"Code";
            iconColor = HexRGB(0xE1981A);
            [cell setShimmeringViewHidden:YES];
            break;
        case 1:
            title = @"Manage your chaos";
            icon = @"Checklist";
            iconColor = HexRGB(0xBF000D);
            [cell setShimmeringViewHidden:YES];
            break;
        case 2:
            title = @"Find the right tools";
            icon = @"Rocket";
            iconColor = HexRGB(0xF1EB9F);
            [cell setShimmeringViewHidden:NO];
            break;
            
        default:
            break;
    }
    cell.backgroundColor = _datas[index];
    cell.titleLabel.text = title;
    cell.titleLabel.textColor = iconColor;
    cell.image = [UIImage octicon_imageWithIcon:icon backgroundColor:[UIColor clearColor] iconColor:iconColor iconScale:1.f andSize:CGSizeMake(50, 50)];
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
    
    NSLog(@"%ld -> %ld",fromIndex,toIndex);
}

- (void)pagerViewWillBeginDragging:(TYCyclePagerView *)pageView {
    
    NSInteger curIndex = [pageView curIndex];
    if (curIndex == 2) {
        
        [self.viewModel.didScrollCommand execute:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
