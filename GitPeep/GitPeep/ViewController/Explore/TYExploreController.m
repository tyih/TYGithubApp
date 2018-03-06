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

@interface TYExploreController ()

@end

@implementation TYExploreController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    imgView.backgroundColor = [UIColor yellowColor];
    self.tableView.tableHeaderView = imgView;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
