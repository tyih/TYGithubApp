//
//  TYUserDetailController.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/1.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYUserDetailController.h"

#import "TYUserDetailViewModel.h"

@interface TYUserDetailController ()

@property (nonatomic, weak) UIImageView *avatarImgView;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UILabel *loginLabel;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *linkLabel;

@property (nonatomic, weak) UILabel *locationLabel;

@property (nonatomic, weak) UIButton *repoButton;
@property (nonatomic, weak) UIButton *followingButton;
@property (nonatomic, weak) UIButton *followerButton;
@property (nonatomic, weak) UIButton *preButton;

@property (nonatomic, strong, readonly) TYUserDetailViewModel *viewModel;

@property (nonatomic, strong) TYUserDetailModel *detailModel;

@end

@implementation TYUserDetailController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    // 按钮选项
    CGFloat itemW = SCREEN_WIDTH / 3;
    CGFloat itemH = 60;
    UIView *buttonsView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.height-itemH, SCREEN_WIDTH, itemH)];
    
    UIButton *repoButton = [self buttonWithTitle:@"Repositories" number:18 rect:CGRectMake(0, 0, itemW, itemH)];
    [buttonsView addSubview:repoButton];
    self.repoButton = repoButton;
    
    UIButton *followingButton = [self buttonWithTitle:@"Following" number:48 rect:CGRectMake(itemW, 0, itemW, itemH)];
    [buttonsView addSubview:followingButton];
    self.followingButton = followingButton;
    
    UIButton *followerButton = [self buttonWithTitle:@"Follower" number:28 rect:CGRectMake(itemW*2, 0, itemW, itemH)];
    [buttonsView addSubview:followerButton];
    self.followerButton = followerButton;
    
    // 默认选中 repoButton
    repoButton.selected = YES;
    self.preButton = repoButton;
    [self setButtonItemsColor:repoButton];
    
    [headerView addSubview:buttonsView];
    
    self.tableView.tableHeaderView = headerView;
    
    @weakify(self);
    [[self.viewModel.requestUserDetailCommand execute:nil] subscribeNext:^(TYUserDetailModel *model) {
        @strongify(self);
        
        [avatarImgView sd_setImageWithURL:[NSURL URLWithString:model.avatar_url]];
        self.detailModel = model;
    }];

}

- (UIButton *)buttonWithTitle:(NSString *)title number:(NSInteger)number rect:(CGRect)rect {
    
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    UILabel *numLabel = [UILabel labelWithText:[NSString stringWithFormat:@"%ld", number] frame:CGRectMake(0, 0, rect.size.width, rect.size.height*0.5) font:BoldSystemFont(15.f) color:[UIColor blackColor] alignment:NSTextAlignmentCenter];
    numLabel.tag = 100;
    UILabel *nameLabel = [UILabel labelWithText:title frame:CGRectMake(0, numLabel.bottom, rect.size.width, rect.size.height*0.5) font:BoldSystemFont(15.f) color:[UIColor blackColor] alignment:NSTextAlignmentCenter];
    nameLabel.tag = 101;
    [button addSubview:numLabel];
    [button addSubview:nameLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(30, button.height-3, rect.size.width-60, 3)];
    line.backgroundColor = HexRGB(colorA1);
    line.tag = 102;
    line.hidden = YES;
    [button addSubview:line];
    
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        @strongify(self);
        self.preButton.selected = NO;
        [self setButtonItemsColor:self.preButton];
        
        button.selected = YES;
        [self setButtonItemsColor:button];
        
        self.preButton = button;
    }];
    
    return button;
}

- (void)setButtonItemsColor:(UIButton *)button {
    
    UILabel *numLabel = [button viewWithTag:100];
    UILabel *nameLabel = [button viewWithTag:101];
    UIView *line = [button viewWithTag:102];
    
    if (button.selected) {
        
        numLabel.textColor = [UIColor redColor];
        nameLabel.textColor = [UIColor redColor];
        line.hidden = NO;
    } else {
        
        numLabel.textColor = [UIColor blackColor];
        nameLabel.textColor = [UIColor blackColor];
        line.hidden = YES;
    }
}

- (void)bindViewModel {
    [super bindViewModel];
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
