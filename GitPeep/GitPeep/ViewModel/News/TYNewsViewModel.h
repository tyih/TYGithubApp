//
//  TYNewsViewModel.h
//  GitPeep
//
//  Created by tiany on 2018/1/15.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYTableViewModel.h"

@interface TYNewsViewModel : TYTableViewModel

@property (nonatomic, strong, readonly) RACCommand *didClickLinkCommand;

@end
