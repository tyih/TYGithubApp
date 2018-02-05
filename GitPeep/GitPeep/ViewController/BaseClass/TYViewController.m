//
//  TYViewController.m
//  GitPeep
//
//  Created by tiany on 2018/1/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYViewController.h"

#import "TYViewModel.h"

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
    
    [self.viewModel.errors subscribeNext:^(NSError *error) {
        NSLog(@"viewModel error")
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
