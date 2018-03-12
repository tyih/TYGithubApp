//
//  TYRepositoriesController.m
//  GitPeep
//
//  Created by tiany on 2018/1/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYRepositoriesController.h"

#import "TYRepositoriesItemCell.h"

@interface TYRepositoriesController ()

@end

@implementation TYRepositoriesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage octicon_imageWithIcon:@"Globe" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] iconScale:1.f andSize:CGSizeMake(25, 25)] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemDidClick:)];
}

#pragma mark - action

- (IBAction)rightBarButtonItemDidClick:(id)sender {
    
    
}

#pragma mark - tableView

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    
    TYRepositoriesItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"repositoriesItemCell"];
    if (cell == nil) {
        cell = [[TYRepositoriesItemCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"repositoriesItemCell"];
    }
    return cell;
}

- (void)configureCell:(TYRepositoriesItemCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    
    [cell setObj:object withIndexPath:indexPath];
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 140;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
