//
//  TYWebViewController.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/23.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYWebViewController.h"

#import "TYWebViewModel.h"

@interface TYWebViewController ()

@property (nonatomic, weak, readwrite) UIWebView *webView;

@property (nonatomic, strong, readonly) TYWebViewModel *viewModel;

@end

@implementation TYWebViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    self.webView = webView;
    [self.view addSubview:webView];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    RACSignal *didFinishLoadSignal = [self rac_signalForSelector:@selector(webViewDidFinishLoad:) fromProtocol:@protocol(UIWebViewDelegate)];
    
    RACSignal *didFailLoadSignal = [self rac_signalForSelector:@selector(webView:didFailLoadWithError:) fromProtocol:@protocol(UIWebViewDelegate)];
    
    TYTitleViewType type = self.viewModel.titleViewType;
    RAC(self.viewModel, titleViewType) = [[RACSignal merge:@[didFinishLoadSignal, didFailLoadSignal]] mapReplace:@(type)];
    
    NSParameterAssert(self.viewModel.request);
    
    [self.webView loadRequest:self.viewModel.request];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if (navigationType == UIWebViewNavigationTypeOther) {
        if ([request.URL.scheme isEqualToString:@"http"] || [request.URL.scheme isEqualToString:@"https"]) {
            self.viewModel.titleViewType = TYTitleViewTypeLoading;
        }
        return YES;
    } else {
        [UIApplication.sharedApplication openURL:request.URL];
        return NO;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
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
