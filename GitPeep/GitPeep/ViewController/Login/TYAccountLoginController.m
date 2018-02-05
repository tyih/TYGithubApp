//
//  TYAccountLoginController.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/22.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYAccountLoginController.h"

#import "TYAccountLoginViewModel.h"

@interface TYAccountLoginController () <UITextFieldDelegate>

@property (nonatomic, strong, readonly) TYAccountLoginViewModel *viewModel;

@end

@implementation TYAccountLoginController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 40)];
    accountView.backgroundColor = [UIColor whiteColor];
    UIImageView *accountImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 22, 22)];
    accountImgView.image = [UIImage octicon_ImageWithIcon:@"Person" size:CGSizeMake(22, 22)];
    [accountView addSubview:accountImgView];
    UITextField *accountField = [[UITextField alloc] initWithFrame:CGRectMake(accountImgView.right+5, 5, SCREEN_WIDTH-accountImgView.right-15, 30)];
    accountField.placeholder = @"Username or email address";
    [accountView addSubview:accountField];
    [accountView addSubview:[UIView lineViewWithX:0 y:0 width:SCREEN_WIDTH color:[UIColor lightGrayColor]]];
    
    UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(0, accountView.bottom, SCREEN_WIDTH, 40)];
    passwordView.backgroundColor = [UIColor whiteColor];
    UIImageView *passwordImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 22, 22)];
    passwordImgView.image = [UIImage octicon_ImageWithIcon:@"Lock" size:CGSizeMake(22, 22)];
    [passwordView addSubview:passwordImgView];
    UITextField *passwordField = [[UITextField alloc] initWithFrame:CGRectMake(passwordImgView.right+5, 5, SCREEN_WIDTH-passwordImgView.right-15, 30)];
    passwordField.placeholder = @"Password";
    [passwordView addSubview:passwordField];
    [passwordView addSubview:[UIView lineViewWithX:15 y:0 width:SCREEN_WIDTH-15 color:[UIColor lightGrayColor]]];
    [passwordView addSubview:[UIView lineViewWithX:0 y:40 width:SCREEN_WIDTH color:[UIColor lightGrayColor]]];
    
    [self.view addSubview:accountView];
    [self.view addSubview:passwordView];
    
    if ([SAMKeychain rawLogin] != nil) {
        accountField.text = [SAMKeychain rawLogin];
        passwordField.text = [SAMKeychain password];
    }
    
    @weakify(self);
    [[self rac_signalForSelector:@selector(textFieldShouldReturn:) fromProtocol:@protocol(UITextFieldDelegate)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        if (x.first == passwordField) {
            [self.viewModel.loginCommand execute:nil];
        }
    }];
    
    passwordField.delegate = self;
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
