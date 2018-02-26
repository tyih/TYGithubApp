//
//  TYTableViewController.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/26.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYViewController.h"

@interface TYTableViewController : TYViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak, readonly) UITableView *tableView;

- (void)reloadData;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

@end
