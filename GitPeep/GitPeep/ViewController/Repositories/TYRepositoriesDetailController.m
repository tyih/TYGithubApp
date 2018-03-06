//
//  TYRepositoriesDetailController.m
//  GitPeep
//
//  Created by tiany on 2018/3/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYRepositoriesDetailController.h"

#import "TYRepositoriesDetailViewModel.h"
#import "TYTabButtonsView.h"
#import "TYUsersCell.h"
#import "TYRepositoriesItemModel.h"

@interface TYRepositoriesDetailController ()

@property (nonatomic, weak) TYTabButtonsView *buttonsView;

@property (nonatomic, strong, readonly) TYRepositoriesDetailViewModel *viewModel;

@property (nonatomic, strong) TYRepositoriesItemModel *detailModel;

@property (nonatomic, weak) UILabel *fullNameLabel;
@property (nonatomic, weak) UIImageView *avatarImgView;
@property (nonatomic, weak) UILabel *createTimeLabel;
@property (nonatomic, weak) UILabel *descriptionLabel;

@end

@implementation TYRepositoriesDetailController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *headerView = [self reposDetailHeaderView];
    self.tableView.tableHeaderView = headerView;
}

- (UIView *)reposDetailHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 180, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:line];
    
    UILabel *fullNameLabel = [UILabel labelWithText:nil frame:CGRectMake(10, 10, 250, 30) font:BoldSystemFont(16.f) color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
    [headerView addSubview:fullNameLabel];
    self.fullNameLabel = fullNameLabel;
    
    UIImageView *avatarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-30, 10, 30, 30)];
    avatarImgView.layer.borderWidth = 0.3f;
    avatarImgView.layer.cornerRadius = 3.f;
    avatarImgView.layer.masksToBounds = YES;
    [headerView addSubview:avatarImgView];
    self.avatarImgView = avatarImgView;
    
    UILabel *createTimeLabel = [UILabel labelWithText:nil frame:CGRectMake(fullNameLabel.left, fullNameLabel.bottom, 100, 20) font:SystemFont(12.f) color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
    [headerView addSubview:createTimeLabel];
    self.createTimeLabel = createTimeLabel;
    
    UILabel *descriptionLabel = [UILabel labelWithText:nil frame:CGRectMake(fullNameLabel.left, createTimeLabel.bottom+5, 300, 60) font:SystemFont(14.f) color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
    descriptionLabel.numberOfLines = 0;
    [headerView addSubview:descriptionLabel];
    self.descriptionLabel = descriptionLabel;
    
    // tabs
    TYTabButtonsView *buttonsView = [[TYTabButtonsView alloc] initWithTitlesFirst:@"Contributors" second:@"Forks" third:@"Stargazers" frame:CGRectMake(0, headerView.height-60, SCREEN_WIDTH, 60)];
    [headerView addSubview:buttonsView];
    self.buttonsView = buttonsView;
    
    buttonsView.firstLabel.hidden = YES;
    
    // repositoryDetail
    @weakify(self);
    [[self.viewModel.requestReposDetailCommand execute:nil] subscribeNext:^(TYRepositoriesItemModel *model) {
        @strongify(self);
        
        self.detailModel = model;
    }];
    
    return headerView;
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self);
    RAC(self, fullNameLabel.text) = [RACObserve(self, detailModel.full_name) map:^id(NSString *fullName) {
        return fullName;
    }];
    
    RAC(self, createTimeLabel.text) = [RACObserve(self, detailModel.created_at) map:^id(NSString *time) {
        return [time componentsSeparatedByString:@"T"][0];
    }];
    
    RAC(self, descriptionLabel.text) = [RACObserve(self, detailModel.characterization) map:^id(NSString *characterization) {
        return characterization;
    }];
    
    [RACObserve(self, detailModel.owner.avatar_url) subscribeNext:^(NSString *avatarUrl) {
        @strongify(self);
        [self.avatarImgView sd_setImageWithURL:[NSURL URLWithString:avatarUrl]];
    }];
    
    RAC(self, buttonsView.secondLabel.text) = [RACObserve(self, detailModel.forks_count) map:^id(NSNumber *count) {
        return count.stringValue;
    }];
    
    RAC(self, buttonsView.thirdLabel.text) = [RACObserve(self, detailModel.stargazers_count) map:^id(NSNumber *count) {
        return count.stringValue;
    }];
    
    RAC(self, viewModel.chooseType) = [RACObserve(self, buttonsView.chooseType) map:^id(NSNumber *number) {
        @strongify(self);
        
        [self refresh];
        return number;
    }];
}

#pragma mark - tableview

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {

    TYUsersCell *followingCell = [tableView dequeueReusableCellWithIdentifier:@"usersCell"];
    if (followingCell == nil) {
        followingCell = [[TYUsersCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"usersCell"];
    }
    return followingCell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {

    if (self.viewModel.chooseType == TYTabButtonsTypeSecond) {
        TYUsersItemModel *model = ((TYRepositoriesItemModel *)object).owner;
        [(TYUsersCell *)cell setModel:model withIndexPath:indexPath];
    } else {
        [(TYUsersCell *)cell setModel:object withIndexPath:indexPath];
    }
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
