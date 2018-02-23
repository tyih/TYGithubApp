//
//  TYWebViewController.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/23.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYViewController.h"

@interface TYWebViewController : TYViewController <UIWebViewDelegate>

@property (nonatomic, weak, readonly) UIWebView *webView;

@end
