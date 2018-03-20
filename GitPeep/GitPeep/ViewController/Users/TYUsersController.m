//
//  TYUserViewController.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/28.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYUsersController.h"

#import "TYUsersCell.h"

@interface TYUsersController () <HNPopMenuViewDelegate>

@property (nonatomic, strong) NSArray *memuArray;

@end

@implementation TYUsersController

- (NSArray *)memuArray {
    
    if (!_memuArray) {
        NSMutableArray *tempArray = [NSMutableArray array];
        NSArray *titleArray = @[@"USA", @"UK", @"Germany", @"China", @"Canada", @"India", @"France", @"Australia", @"Other"];
        for (NSString *title in titleArray) {
            HNPopMenuModel *model = [[HNPopMenuModel alloc] init];
            model.title = title;
            [tempArray addObject:model];
        }
        _memuArray = tempArray;
    }
    return _memuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage octicon_imageWithIcon:@"Location" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] iconScale:1.f andSize:CGSizeMake(25, 25)] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemDidClick:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage octicon_imageWithIcon:@"Globe" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] iconScale:1.f andSize:CGSizeMake(25, 25)] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemDidClick:)];
}

#pragma mark - action

- (IBAction)leftBarButtonItemDidClick:(id)sender {
    
    [HNPopMenuManager showPopMenuWithView:nil items:self.memuArray delegate:self dismissAutomatically:YES];
}

- (IBAction)rightBarButtonItemDidClick:(id)sender {
    
    
}

#pragma mark - tableview

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    
    TYUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UsersCell"];
    if (cell == nil) {
        cell = [[TYUsersCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UsersCell"];
    }
    return cell;
}

- (void)configureCell:(TYUsersCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    
    [cell setObj:object withIndexPath:indexPath];
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
