//
//  TYUserDetailController.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/1.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYUserDetailController.h"

#import "TYUserDetailViewModel.h"
#import "TYDetailReposItemCell.h"
#import "TYRepositoriesItemModel.h"
#import "TYUsersCell.h"
#import "TYTabButtonsView.h"

@interface TYUserDetailController ()

@property (nonatomic, weak) UIImageView *avatarImgView;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *loginLabel;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *linkLabel;
@property (nonatomic, weak) UILabel *locationLabel;

@property (nonatomic, weak) TYTabButtonsView *buttonsView;

@property (nonatomic, strong, readonly) TYUserDetailViewModel *viewModel;

@property (nonatomic, strong) TYUserDetailModel *detailModel;

@end

@implementation TYUserDetailController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // headerView
    UIView *headerView = [self userDetailHeaderView];
    self.tableView.tableHeaderView = headerView;
}

- (UIView *)userDetailHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:[UIView lineViewWithX:0 y:179 width:SCREEN_WIDTH color:[UIColor lightGrayColor]]];
    
    UIImageView *avatarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 70)];
    avatarImgView.layer.borderWidth = 0.5f;
    avatarImgView.layer.borderColor = [UIColor grayColor].CGColor;
    avatarImgView.layer.cornerRadius = 3.f;
    avatarImgView.layer.masksToBounds = YES;
    [headerView addSubview:avatarImgView];
    self.avatarImgView = avatarImgView;
    
    UILabel *timeLabel = [UILabel labelWithText:@"2017-10-22" frame:CGRectMake(avatarImgView.left, avatarImgView.bottom, avatarImgView.width, 20) font:SystemFont(11.f) color:[UIColor grayColor] alignment:NSTextAlignmentCenter];
    [headerView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *loginLabel = [UILabel labelWithText:@"ZZZZZ" frame:CGRectMake(avatarImgView.right+5, avatarImgView.top, 120, 30) font:SystemFont(15.f) color:HexRGB(colorA1) alignment:NSTextAlignmentLeft];
    [headerView addSubview:loginLabel];
    self.loginLabel = loginLabel;
    
    UILabel *nameLabel = [UILabel labelWithText:@"XXXXXX" frame:CGRectMake(avatarImgView.right+5, loginLabel.bottom, 120, 30) font:SystemFont(14.f) color:HexRGB(colorA2) alignment:NSTextAlignmentLeft];
    [headerView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *linkLabel = [UILabel labelWithText:@"http://blong.xxx.xxxx" frame:CGRectMake(nameLabel.right+5, nameLabel.top, 150, 20) font:SystemFont(13.f) color:HexRGB(colorA1) alignment:NSTextAlignmentLeft];
    [headerView addSubview:linkLabel];
    self.linkLabel = linkLabel;
    
    UILabel *locationLabel = [UILabel labelWithText:@"San Francisco" frame:CGRectMake(linkLabel.left, linkLabel.bottom, 150, 20) font:SystemFont(14.f) color:HexRGB(colorA1) alignment:NSTextAlignmentLeft];
    [headerView addSubview:locationLabel];
    self.locationLabel = locationLabel;
    
    TYTabButtonsView *buttonsView = [[TYTabButtonsView alloc] initWithTitlesFirst:@"Repositories" second:@"Following" third:@"Follower" frame:CGRectMake(0, headerView.height-60, SCREEN_WIDTH, 60)];
    [headerView addSubview:buttonsView];
    self.buttonsView = buttonsView;
    
    // 请求userDetail
    @weakify(self);
    [[self.viewModel.requestUserDetailCommand execute:nil] subscribeNext:^(TYUserDetailModel *model) {
        @strongify(self);
        
        self.detailModel = model;
    }];
    
    return headerView;
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self);
    [RACObserve(self, detailModel.avatar_url) subscribeNext:^(NSString *avatarUrl) {
        @strongify(self);
        [self.avatarImgView sd_setImageWithURL:[NSURL URLWithString:avatarUrl]];
    }];
    
    RAC(self, loginLabel.text) = [RACObserve(self, detailModel.login) map:^id(NSString *login) {
        return login;
    }];
    
    RAC(self, nameLabel.text) = [RACObserve(self, detailModel.name) map:^id(NSString *name) {
        return name;
    }];
    
    RAC(self, timeLabel.text) = [RACObserve(self, detailModel.created_at) map:^id(NSString *created_at) {
        return [created_at componentsSeparatedByString:@"T"][0];
    }];
    
    RAC(self, linkLabel.text) = [RACObserve(self, detailModel.blog) map:^id(NSString *blog) {
        return blog;
    }];
    
    RAC(self, locationLabel.text) = [RACObserve(self, detailModel.location) map:^id(NSString *location) {
        return location;
    }];
    
    RAC(self, buttonsView.firstLabel.text) = [RACObserve(self, detailModel.public_repos) map:^id(NSNumber *number) {
        
        return number.stringValue;
    }];
    
    RAC(self, buttonsView.secondLabel.text) = [RACObserve(self, detailModel.following) map:^id(NSNumber *number) {
        
        return number.stringValue;
    }];
    
    RAC(self, buttonsView.thirdLabel.text) = [RACObserve(self, detailModel.followers) map:^id(NSNumber *number) {
        
        return number.stringValue;
    }];
    
    RAC(self, viewModel.chooseType) = [RACObserve(self, buttonsView.chooseType) map:^id(NSNumber *number) {
        @strongify(self);
        
        [self refresh];
        return number;
    }];
}

#pragma mark - tableview

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    
    switch (self.viewModel.chooseType) {
        case TYTabButtonsTypeFirst: {
            TYDetailReposItemCell *repoCell = [tableView dequeueReusableCellWithIdentifier:@"repoCell"];
            if (repoCell == nil) {
                repoCell = [[TYDetailReposItemCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"repoCell"];
            }
            return repoCell;
        }
        case TYTabButtonsTypeSecond: {
            TYUsersCell *followingCell = [tableView dequeueReusableCellWithIdentifier:@"followingCell"];
            if (followingCell == nil) {
                followingCell = [[TYUsersCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"followingCell"];
            }
            return followingCell;
        }
        case TYTabButtonsTypeThird: {
            TYUsersCell *followerCell = [tableView dequeueReusableCellWithIdentifier:@"followerCell"];
            if (followerCell == nil) {
                followerCell = [[TYUsersCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"followerCell"];
            }
            return followerCell;
        }
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    
    if ([cell isKindOfClass:[TYDetailReposItemCell class]]) {
        
        [(TYDetailReposItemCell *)cell setModel:object withIndexPath:indexPath];
    } else if ([cell isKindOfClass:[TYUsersCell class]]) {
        
        [(TYUsersCell *)cell setModel:object withIndexPath:indexPath];
    }
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (self.viewModel.chooseType) {
        case TYTabButtonsTypeFirst:
            return 140;
        case TYTabButtonsTypeSecond:
            return 80;
        case TYTabButtonsTypeThird:
            return 80;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
