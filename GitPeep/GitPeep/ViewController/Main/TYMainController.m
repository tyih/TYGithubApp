//
//  TYMainController.m
//  GitPeep
//
//  Created by tiany on 2018/1/4.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYMainController.h"

#import "TYMainViewModel.h"
//#import "TYNewsController.h"
#import "TYUsersController.h"
#import "TYReposController.h"
#import "TYExploreController.h"
#import "TYProfileController.h"
#import "TYNavigationControllerStack.h"
#import "TYNavigationController.h"

@interface TYMainController ()

@property (nonatomic, strong) TYMainViewModel *viewModel;

@end

@implementation TYMainController

@dynamic viewModel;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UINavigationController *newsNavCtrl = ({
//        TYNewsController *newsCtrl = [[TYNewsController alloc] initWithViewModel:self.viewModel.newsViewModel];
//        UIImage *newImage = [UIImage octicon_imageWithIcon:@"Rss"
//                                           backgroundColor:[UIColor clearColor]
//                                                 iconColor:[UIColor lightGrayColor]
//                                                 iconScale:1.f
//                                                   andSize:CGSizeMake(25, 25)];
//        UIImage *newHLImage = [UIImage octicon_imageWithIcon:@"Rss"
//                                           backgroundColor:[UIColor clearColor]
//                                                 iconColor:[UIColor yellowColor]
//                                                 iconScale:1.f
//                                                   andSize:CGSizeMake(25, 25)];
//        newsCtrl.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"News" image:newImage selectedImage:newHLImage];
//        [[TYNavigationController alloc] initWithRootViewController:newsCtrl];
//    });
    UINavigationController *usersNavCtrl = ({
        TYUsersController *usersCtrl = [[TYUsersController alloc] initWithViewModel:self.viewModel.usersViewModel];
        UIImage *usersImage = [UIImage octicon_imageWithIcon:@"Rss"
                                           backgroundColor:[UIColor clearColor]
                                                 iconColor:[UIColor lightGrayColor]
                                                 iconScale:1.f
                                                   andSize:CGSizeMake(25, 25)];
        UIImage *usersHLImage = [UIImage octicon_imageWithIcon:@"Rss"
                                             backgroundColor:[UIColor clearColor]
                                                   iconColor:[UIColor yellowColor]
                                                   iconScale:1.f
                                                     andSize:CGSizeMake(25, 25)];
        usersCtrl.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Users" image:usersImage selectedImage:usersHLImage];
        [[TYNavigationController alloc] initWithRootViewController:usersCtrl];
    });
    
    UINavigationController *reposNavCtrl = ({
        TYReposController *reposCtrl = [[TYReposController alloc] initWithViewModel:self.viewModel.reposViewModel];
        UIImage *reposImage = [UIImage octicon_imageWithIcon:@"Repo"
                                           backgroundColor:[UIColor clearColor]
                                                 iconColor:[UIColor lightGrayColor]
                                                 iconScale:1.f
                                                   andSize:CGSizeMake(25, 25)];
        UIImage *reposHLImage = [UIImage octicon_imageWithIcon:@"Repo"
                                             backgroundColor:[UIColor clearColor]
                                                   iconColor:[UIColor yellowColor]
                                                   iconScale:1.f
                                                     andSize:CGSizeMake(25, 25)];
        reposCtrl.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Repositories" image:reposImage selectedImage:reposHLImage];
        [[TYNavigationController alloc] initWithRootViewController:reposCtrl];
    });
    
    UINavigationController *exploreNavCtrl = ({
        TYExploreController *exploreCtrl = [[TYExploreController alloc] initWithViewModel:self.viewModel.exploreViewModel];
        UIImage *exploreImage = [UIImage octicon_imageWithIcon:@"Search"
                                           backgroundColor:[UIColor clearColor]
                                                 iconColor:[UIColor lightGrayColor]
                                                 iconScale:1.f
                                                   andSize:CGSizeMake(25, 25)];
        UIImage *exploreHLImage = [UIImage octicon_imageWithIcon:@"Search"
                                             backgroundColor:[UIColor clearColor]
                                                   iconColor:[UIColor yellowColor]
                                                   iconScale:1.f
                                                     andSize:CGSizeMake(25, 25)];
        exploreCtrl.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Explore" image:exploreImage selectedImage:exploreHLImage];
        [[TYNavigationController alloc] initWithRootViewController:exploreCtrl];
    });
    
    UINavigationController *profileNavCtrl = ({
        TYProfileController *profileCtrl = [[TYProfileController alloc] initWithViewModel:self.viewModel.profileViewModel];
        UIImage *profileImage = [UIImage octicon_imageWithIcon:@"Person"
                                           backgroundColor:[UIColor clearColor]
                                                 iconColor:[UIColor lightGrayColor]
                                                 iconScale:1.f
                                                   andSize:CGSizeMake(25, 25)];
        UIImage *profileHLImage = [UIImage octicon_imageWithIcon:@"Person"
                                             backgroundColor:[UIColor clearColor]
                                                   iconColor:[UIColor yellowColor]
                                                   iconScale:1.f
                                                     andSize:CGSizeMake(25, 25)];
        profileCtrl.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:profileImage selectedImage:profileHLImage];
        [[TYNavigationController alloc] initWithRootViewController:profileCtrl];
    });
    
    self.tabBarController.viewControllers = @[usersNavCtrl, reposNavCtrl, exploreNavCtrl, profileNavCtrl];
    
    [TYSharedAppDelegate.navigationControllerStack pushNavigationController:usersNavCtrl];
    
    [[self rac_signalForSelector:@selector(tabBarController:didSelectViewController:)
                    fromProtocol:@protocol(UITabBarControllerDelegate)] subscribeNext:^(RACTuple * _Nullable x) {
        [TYSharedAppDelegate.navigationControllerStack popNavigationController];
        [TYSharedAppDelegate.navigationControllerStack pushNavigationController:x.second];
    }];
    
    self.tabBarController.delegate = self;
    
#if 1
    YYFPSLabel *fpsLabel = [[YYFPSLabel alloc] init];
    fpsLabel.frame = CGRectMake(110, 0, 0, 0);
//    fpsLabel.backgroundColor = [UIColor yellowColor];
    fpsLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    [fpsLabel sizeToFit];
    
    [self.navigationController.view addSubview:fpsLabel];
    
#endif
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if (self.tabBarController.selectedViewController == viewController) {
        UINavigationController *navCtrl = (UINavigationController *)viewController;
        UIViewController *viewCtrl = navCtrl.topViewController;
        if ([viewCtrl isKindOfClass:[TYUsersController class]]) {
            TYUsersController *usersCtrl = (TYUsersController *)viewCtrl;
            [usersCtrl refresh];
        }
    }
    return YES;
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
