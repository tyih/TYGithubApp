//
//  TYViewController.m
//  GitPeep
//
//  Created by tiany on 2018/1/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYViewController.h"

#import "TYViewModel.h"
#import "TYLoginViewModel.h"
#import "TYViewModelServices.h"

@interface TYViewController ()

@property (nonatomic, strong, readwrite) TYViewModel *viewModel;

@end

@implementation TYViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    TYViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController);
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(viewController);
        [viewController bindViewModel];
    }];
    return viewController;
}

- (instancetype)initWithViewModel:(TYViewModel *)viewModel {
    
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.viewModel.willDisappearSignal sendNext:nil];
    
    if ([self isMovingFromParentViewController]) {
        self.snapshot = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
    }
}

- (void)bindViewModel {

    RAC(self.navigationItem, title) = RACObserve(self, viewModel.title);
    
    UIView *titleView = self.navigationItem.titleView;
    @weakify(self);
    [[self rac_signalForSelector:@selector(viewWillTransitionToSize:withTransitionCoordinator:)] subscribeNext:^(id x) {
        @strongify(self);
        // 屏幕翻转
    }];
    
    // Loading title view
    UILabel *loadingView = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-150)*0.5, 0, 150, 40)];
    loadingView.text = @"Loading...";
    loadingView.textColor = [UIColor whiteColor];
    loadingView.textAlignment = NSTextAlignmentCenter;
    
    RAC(self.navigationItem, titleView) = [RACObserve(self.viewModel, titleViewType).distinctUntilChanged map:^id(NSNumber *value) {
        TYTitleViewType titleViewType = value.unsignedIntegerValue;
        switch (titleViewType) {
            case TYTitleViewTypeDefault:
                return titleView;
            case TYTitleViewTypeDoubleTitle:
                return titleView;
            case TYTitleViewTypeLoading:
                return loadingView;
        }
    }];
    
    
    [self.viewModel.errors subscribeNext:^(NSError *error) {
        @strongify(self);
        
        NSLog(@"error: %@", error)
        
        if ([error.domain isEqual:OCTClientErrorDomain] && error.code == OCTClientErrorAuthenticationFailed) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:TY_ALERT_TITLE
                                                                                     message:@"Your authorization has expired, please login again"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                @strongify(self)
                [SAMKeychain deleteAccessToken];
                
                TYLoginViewModel *loginViewModel = [[TYLoginViewModel alloc] initWithServices:self.viewModel.services params:nil];
                [self.viewModel.services resetRootViewModel:loginViewModel];
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        } else if (error.code != OCTClientErrorTwoFactorAuthenticationOneTimePasswordRequired && error.code != OCTClientErrorConnectionFailed) {
            NSLog(@"ERROR: %@", error.localizedDescription)
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = HexRGB(colorA3);
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
