//
//  TYTableViewController.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/26.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYTableViewController.h"

#import "TYTableViewModel.h"

@interface TYTableViewController ()

@property (nonatomic, weak, readonly) TYTableViewModel *viewModel;

@end

@implementation TYTableViewController

@dynamic viewModel;

- (instancetype)initWithViewModel:(TYViewModel *)viewModel {
    
    self = [super initWithViewModel:viewModel];
    if (self) {
        
        // 默认在viewDidLoad的时候请求
        @weakify(self);
        [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
            @strongify(self);
            [self.viewModel.requestRemoteDataCommand execute:@1];
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)reloadData {
    
    
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellStyle1" forIndexPath:indexPath];
    id object = self.viewModel.dataArray[indexPath.row];
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    
    return cell;
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
