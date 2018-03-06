//
//  TYTableViewController.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/26.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYTableViewController.h"

#import "TYTableViewModel.h"
#import "TYRefreshGifHeader.h"

@interface TYTableViewController ()

@property (nonatomic, weak, readonly) TYTableViewModel *viewModel;

@property (nonatomic, weak, readwrite) UITableView *tableView;

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
            // 请求数据，刷新
            [self.tableView.mj_header beginRefreshing];
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    TYRefreshGifHeader *refreshHeader = [TYRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self requestRemoteData];
    }];
    self.tableView.mj_header = refreshHeader;
}

- (void)reloadData {
    
    [self.tableView reloadData];
}

- (void)refresh {
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)requestRemoteData {
    
    @weakify(self);
    [[self.viewModel.requestRemoteDataCommand execute:nil] subscribeNext:^(id x) {
        
        @strongify(self);
        self.viewModel.dataArray = x;
        if (self.viewModel.dataArray.count > 0) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        [self.tableView reloadData];        
    } completed:^{
        
        [self.tableView.mj_header endRefreshing];
    }];

}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    // 默认样式
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    // 用于子类重写
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"cellStyle1" forIndexPath:indexPath];
    id object = self.viewModel.dataArray[indexPath.row];
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [self heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 返回时选中状态消失
    [self.viewModel.didSelectCommand execute:indexPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
