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

/// 子类重写-自定义cell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

/// 子类重写-cell数据设置
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

/// 子类重写-cell高度
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
