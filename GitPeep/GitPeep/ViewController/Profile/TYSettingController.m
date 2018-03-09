//
//  TYSettingController.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/9.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYSettingController.h"

#import "TYSettingViewModel.h"
#import "TYSettingsCell.h"

@interface TYSettingController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, readonly) TYSettingViewModel *viewModel;

@end

@implementation TYSettingController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.viewModel.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TYSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    if (!cell) {
        cell = [[TYSettingsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"settingCell"];
    }
    [cell setObj:self.viewModel.dataArray[indexPath.section][indexPath.row] withIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 返回时选中状态消失
    [self.viewModel.didSelectCommand execute:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
