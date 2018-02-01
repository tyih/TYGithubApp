//
//  TYNavigationController.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/1.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYNavigationController.h"

@interface TYNavigationController ()

@end

@implementation TYNavigationController

- (BOOL)shouldAutorotate {
    
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return self.topViewController.preferredStatusBarStyle;
}

@end
