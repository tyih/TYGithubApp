//
//  TYNewsController.m
//  GitPeep
//
//  Created by tiany on 2018/1/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYNewsController.h"

#import "TYNewsViewModel.h"
#import "TYNewsItemViewModel.h"
#import "TYNewsCell.h"

@interface TYNewsController ()

@property (nonatomic, strong, readonly) TYNewsViewModel *viewModel;

@end

@implementation TYNewsController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];

}

//- (void)bindViewModel {
//    [super bindViewModel];
//
//    刷新状态
//    @weakify(self);
//    [self.viewModel.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *excuting) {
//        @strongify(self);
//        if (excuting.boolValue) {
//            [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES].label.text = @"Loading...";
//        } else {
//            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
//        }
//    }];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    
    TYNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    if (cell == nil) {
        cell = [[TYNewsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"NewsCell"];
    }
    return cell;
}

- (void)configureCell:(TYNewsCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(TYNewsItemViewModel *)viewModel {
    
    [cell bindViewModel:viewModel];
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 88;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
