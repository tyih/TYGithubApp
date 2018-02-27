//
//  TYLoginViewModel.h
//  GitPeep
//
//  Created by tiany on 2018/1/15.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYViewModel.h"

@interface TYLoginViewModel : TYViewModel

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

@property (nonatomic, strong, readonly) RACSignal *validLoginSignal;

@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@property (nonatomic, strong, readonly) RACCommand *browserLoginCommand;

@property (nonatomic, strong, readonly) RACCommand *exchangeTokenCommand;

@end
