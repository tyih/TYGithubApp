//
//  TYOAuthViewController.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/23.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYOAuthViewController.h"

#import "TYOAuthViewModel.h"

@interface TYOAuthViewController ()

@property (nonatomic, strong, readonly) TYOAuthViewModel *viewModel;

@end

@implementation TYOAuthViewController

@dynamic viewModel;

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSArray *urlArray = [request.URL.absoluteString componentsSeparatedByString:@"?"];
    if ([urlArray[0] isEqualToString:@"http://tianyao.gitpeep/"]) {
        NSDictionary *queryArguments = request.URL.oct_queryArguments;
        if ([queryArguments[@"state"] isEqual:self.viewModel.UUIDString]) {
            if (self.viewModel.callback) {
                self.viewModel.callback(queryArguments[@"code"]);
            }
        }
        return NO;
    }
    
    if (navigationType == UIWebViewNavigationTypeOther) {
        return [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    } else {
        return YES;
    }
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
