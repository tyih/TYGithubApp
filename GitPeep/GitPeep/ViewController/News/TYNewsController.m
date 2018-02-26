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
    
    
    
//    [self refresh];
}

- (void)refresh {
    
    [self.viewModel.requestRemoteDataCommand execute:nil];
//    @weakify(self);
//    RACSignal *signal = [self.viewModel.requestRemoteDataCommand execute:nil];
//    [signal subscribeNext:^(id x) {
//
//        @strongify(self);
////        self.viewModel.dataArray = x;
//        [self reloadData];
//    }];
}

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
