//
//  TYProfileController.m
//  GitPeep
//
//  Created by tiany on 2018/1/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYProfileController.h"

@interface TYProfileController ()

@property (nonatomic, weak) UIView *headerView;

@property (nonatomic, weak) UIImageView *headerImageView;

@end

@implementation TYProfileController

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//
//    self.navigationController.navigationBar.hidden = YES;
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//
//    self.navigationController.navigationBar.hidden = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    headerImageView.image = [UIImage imageNamed:@"timg"];
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.clipsToBounds = YES;
    
//    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
//    navView.backgroundColor = HexRGB(colorA1);
//    navView.clipsToBounds = YES;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    [headerView addSubview:headerImageView];
    self.headerImageView = headerImageView;
    self.headerView = headerView;
    self.tableView.tableHeaderView = headerView;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint offset = scrollView.contentOffset;
    if (offset.y < 0) {
        CGRect rect = self.headerView.frame;
        rect.origin.y = offset.y;
        rect.size.height = CGRectGetHeight(rect) - offset.y;
        self.headerImageView.frame = rect;
        self.headerView.clipsToBounds = NO;
    }
}

- (BOOL)isHeaderRefreshing {
    
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
