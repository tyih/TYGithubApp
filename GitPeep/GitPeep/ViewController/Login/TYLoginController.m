//
//  TYLoginController.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/22.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYLoginController.h"

#import "TYLoginViewModel.h"
#import "TYButton.h"

@interface TYLoginController () <UITextFieldDelegate>

@property (nonatomic, strong, readonly) TYLoginViewModel *viewModel;

@property (nonatomic, weak) UITextField *usernameField;
@property (nonatomic, weak) UITextField *passwordField;
@property (nonatomic, weak) TYButton *loginButton;

@end

@implementation TYLoginController

@dynamic viewModel;

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat logoX = (SCREEN_WIDTH - 50) * 0.5;
    CGFloat logoY = TOP_BAR_HEIGHT + 30;
    CGFloat logoW = 50;
    CGFloat logoH = 50;
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(logoX, logoY, logoW, logoH)];
    logoImgView.image = [UIImage octicon_ImageWithIcon:@"MarkGithub" size:CGSizeMake(logoW, logoH)];
    [self.view addSubview:logoImgView];
    
    UILabel *titleLabel = [UILabel labelWithText:@"Sign in to Github" frame:CGRectMake(0, logoImgView.bottom+35, SCREEN_WIDTH, 25) font:[UIFont fontWithName:@"PingFangSC-Regular" size:20.f] color:nil alignment:NSTextAlignmentCenter];
    [self.view addSubview:titleLabel];
    
    CGFloat signInW = 310;
    CGFloat signInH = 260;
    CGFloat signInX = (SCREEN_WIDTH - signInW) * 0.5;
    CGFloat signInY = titleLabel.bottom + 25;
    UIView *signInView = [[UIView alloc] initWithFrame:CGRectMake(signInX, signInY, signInW, signInH)];
    signInView.backgroundColor = [UIColor whiteColor];
    signInView.layer.cornerRadius = 5.f;
    signInView.layer.borderWidth = 1.f;
    signInView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    signInView.layer.masksToBounds = YES;
    [self.view addSubview:signInView];
    
    CGFloat fieldW = 265;
    CGFloat fieldH = 35;
    CGFloat fieldX = (signInView.width - fieldW) * 0.5;
    UILabel *usernameLabel = [UILabel labelWithText:@"Username or email address" frame:CGRectMake(fieldX, 26, fieldW, 15) font:[UIFont boldSystemFontOfSize:15.f] color:nil alignment:NSTextAlignmentLeft];
    [signInView addSubview:usernameLabel];
    UITextField *usernameField = [[UITextField alloc] initWithFrame:CGRectMake(fieldX, usernameLabel.bottom+12, fieldW, fieldH)];
    usernameField.layer.borderWidth = 1.f;
    usernameField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, fieldH)];
    usernameField.leftView = leftView1;
    usernameField.leftViewMode = UITextFieldViewModeAlways;
    self.usernameField = usernameField;
    [signInView addSubview:usernameField];
    
    UILabel *passwordLabel = [UILabel labelWithText:@"Password" frame:CGRectMake(fieldX, usernameField.bottom+20, fieldW, 15) font:[UIFont boldSystemFontOfSize:15.f] color:nil alignment:NSTextAlignmentLeft];
    [signInView addSubview:passwordLabel];
    UITextField *passwordField = [[UITextField alloc] initWithFrame:CGRectMake(fieldX, passwordLabel.bottom+12, fieldW, fieldH)];
    passwordField.secureTextEntry = YES;
    passwordField.delegate = self;
    passwordField.layer.borderWidth = 1.f;
    passwordField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, fieldH)];
    passwordField.leftView = leftView2;
    passwordField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordField = passwordField;
    [signInView addSubview:passwordField];
    
    TYButton *loginButton = [[TYButton alloc] initWithFrame:CGRectMake(fieldX, passwordField.bottom+20, fieldW, 35)];
    [loginButton setTitle:@"Sign in" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    loginButton.layer.cornerRadius = 5.f;
    self.loginButton = loginButton;
    [signInView addSubview:loginButton];
    
    // 显示账号密码
    if ([SAMKeychain rawLogin] != nil) {
        usernameField.text = [SAMKeychain rawLogin];
        passwordField.text = [SAMKeychain password];
    }
    
    // textFieldShouldReturn: 代理方法触发
    @weakify(self);
    [[self rac_signalForSelector:@selector(textFieldShouldReturn:) fromProtocol:@protocol(UITextFieldDelegate)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        if (x.first == passwordField) { // 输入密码后按回车键
            [self.viewModel.loginCommand execute:nil];
        }
    }];
    
}

- (void)bindViewModel {
    [super bindViewModel];
    
    RAC(self.viewModel, username) = self.usernameField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordField.rac_textSignal;
    
    RAC(self.loginButton, enabled) = self.viewModel.validLoginSignal;
    // 登录按钮点击
    @weakify(self);
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel.loginCommand execute:nil];
    }];
    
    
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
