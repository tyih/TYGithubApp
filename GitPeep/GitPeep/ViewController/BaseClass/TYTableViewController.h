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

/// 刷新tableView
- (void)reloadData;

/// 请求数据、刷新
- (void)refresh;

/// 用于子类重写
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
