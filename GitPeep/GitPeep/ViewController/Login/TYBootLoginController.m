//
//  TYBootLoginController.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/22.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYBootLoginController.h"

@interface TYBootLoginController ()

@end

@implementation TYBootLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIImage *img = [UIImage octicon_imageWithIcon:@"Heart" backgroundColor:[UIColor whiteColor] iconColor:[UIColor redColor] iconScale:1.f andSize:CGSizeMake(150.f, 150.f)];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [self.view addSubview:imgView];
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
