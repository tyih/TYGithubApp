//
//  TYNewsItemViewModel.h
//  GitPeep
//
//  Created by tiany on 2018/2/26.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYNewsItemViewModel : NSObject

@property (nonatomic, copy, readonly) NSString *title;

@property (nonatomic, copy, readonly) NSString *time;

@property (nonatomic, strong) RACCommand *didClickLinkCommand;

- (instancetype)initWithTitle:(NSString *)title time:(NSString *)time;

@end
