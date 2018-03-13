//
//  TYProfileController.m
//  GitPeep
//
//  Created by tiany on 2018/1/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYProfileController.h"

#import "TYProfileViewModel.h"
#import "TYProfileCell.h"

typedef NS_ENUM(NSUInteger, TYProfileTabType) {
    TYProfileTabTypeFollowers = 100,
    TYProfileTabTypeRepositories,
    TYProfileTabTypeFollowing,
};

@interface TYProfileController ()

@property (nonatomic, weak) UIView *headerView;

@property (nonatomic, weak) UIImageView *bluerdImageView;

@property (nonatomic, strong) GPUImageGaussianBlurFilter *gaussianBlurFilter;

@property (nonatomic, strong) UIImage *avatarImage;

@property (nonatomic, strong, readonly) TYProfileViewModel *viewModel;

@property (nonatomic, weak) UILabel *followersLabel;
@property (nonatomic, weak) UILabel *repositoriesLabel;
@property (nonatomic, weak) UILabel *followingLabel;

@end

@implementation TYProfileController

@dynamic viewModel;

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//
//    self.navigationController.navigationBar.hidden = YES;
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//
//    self.navigationController.navigationBar.hidden = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 高斯背景图
    UIImageView *bluerdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    bluerdImageView.contentMode = UIViewContentModeScaleAspectFill;
    bluerdImageView.clipsToBounds = YES;
    
    // 头像
    UIButton *avatarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    avatarButton.layer.cornerRadius = 40;
    avatarButton.layer.masksToBounds = YES;
    avatarButton.center = bluerdImageView.center;
    avatarButton.backgroundColor = [UIColor whiteColor];
    
    UIView *headerView = [[UIView alloc] initWithFrame:bluerdImageView.bounds];
    [headerView addSubview:bluerdImageView];
    [headerView addSubview:avatarButton];
    self.bluerdImageView = bluerdImageView;
    
    self.headerView = headerView;
    self.tableView.tableHeaderView = headerView;
    
    self.gaussianBlurFilter = [[GPUImageGaussianBlurFilter alloc] init];
    self.gaussianBlurFilter.blurRadiusInPixels = 10;
    
    self.avatarImage = [UIImage imageNamed:@"timg"]; // 默认图
    
    // tabs
    CGFloat tabBtnW = SCREEN_WIDTH / 3;
    UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(0, bluerdImageView.height-60, SCREEN_WIDTH, 60)];
    tabView.backgroundColor = [UIColor whiteColor];

    UIButton *followersBtn = [self tabButtonWithNum:nil title:@"Followers" x:0];
    self.followersLabel = [followersBtn viewWithTag:10];
    [tabView addSubview:followersBtn];
    UIButton *repositoriesBtn = [self tabButtonWithNum:nil title:@"Repositories" x:tabBtnW];
    self.repositoriesLabel = [repositoriesBtn viewWithTag:10];
    [tabView addSubview:repositoriesBtn];
    UIButton *followingBtn = [self tabButtonWithNum:nil title:@"Following" x:tabBtnW * 2];
    self.followingLabel = [followingBtn viewWithTag:10];
    [tabView addSubview:followingBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, tabView.height, SCREEN_WIDTH, 0.3)];
    line.backgroundColor = [UIColor lightGrayColor];
    [tabView addSubview:line];
    
    [headerView addSubview:tabView];
    
    @weakify(self);
    RAC(bluerdImageView, image) = [RACObserve(self, avatarImage) map:^id(UIImage *image) {
        @strongify(self);

        return [self.gaussianBlurFilter imageByFilteringImage:image];
    }];
    
    [[[RACObserve(self, viewModel.userModel.avatar_url) ignore:nil] distinctUntilChanged] subscribeNext:^(NSString *avatarUrl) {
        
        [SDWebImageManager.sharedManager loadImageWithURL:[NSURL URLWithString:avatarUrl] options:SDWebImageRefreshCached progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            @strongify(self);
            
            if (image && finished) {
                self.avatarImage = image;
                [avatarButton setImage:image forState:UIControlStateNormal];
            }
        }];
    }];
    
    RAC(self, followersLabel.text) = [RACObserve(self, viewModel.userModel.followers) map:^id(NSNumber *number) {
        
        return number.stringValue;
    }];
    
    RAC(self, repositoriesLabel.text) = [RACObserve(self, viewModel.userModel.public_repos) map:^id(NSNumber *number) {
        
        return number.stringValue;
    }];
    
    RAC(self, followingLabel.text) = [RACObserve(self, viewModel.userModel.following) map:^id(NSNumber *number) {
        
        return number.stringValue;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint offset = scrollView.contentOffset;
    if (offset.y < 0) {
        CGRect rect = self.headerView.frame;
        rect.origin.y = offset.y;
        rect.size.height = CGRectGetHeight(rect) - offset.y;
        self.bluerdImageView.frame = rect;
        self.headerView.clipsToBounds = NO;
    }
}

- (UITableViewStyle)tableViewStyle {
    
    return UITableViewStyleGrouped;
}

- (BOOL)isHeaderRefreshing {
    
    return NO;
}

- (UIButton *)tabButtonWithNum:(NSString *)num title:(NSString *)title x:(CGFloat)x {
    
    CGFloat tabBtnW = SCREEN_WIDTH / 3;
    UIButton *tabButton = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, tabBtnW, 60)];
    UILabel *numLabel = [UILabel labelWithText:num frame:CGRectMake(0, 0, tabBtnW, 30) font:BoldSystemFont(16.f) color:[UIColor blackColor] alignment:NSTextAlignmentCenter];
    numLabel.tag = 10;
    [tabButton addSubview:numLabel];
    UILabel *titleLabel = [UILabel labelWithText:title frame:CGRectMake(0, 30, tabBtnW, 30) font:SystemFont(16.f) color:[UIColor blackColor] alignment:NSTextAlignmentCenter];
    [tabButton addSubview:titleLabel];
    
    [[tabButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        
        TYProfileTabType type = button.tag;
        switch (type) {
            case TYProfileTabTypeFollowers:
                
                break;
            case TYProfileTabTypeRepositories:
                
                break;
            case TYProfileTabTypeFollowing:
                
                break;
        }
    }];
    
    return tabButton;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.viewModel.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TYProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell"];
    if (!cell) {
        cell = [[TYProfileCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"profileCell"];
    }
    NSString *titleString = self.viewModel.dataArray[indexPath.section][indexPath.row];
    [cell setObj:titleString withIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 返回时选中状态消失
    if (indexPath.section == 1 && indexPath.row == 0) { // 设置
        [self.viewModel.didSelectCommand execute:indexPath];
    }
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
