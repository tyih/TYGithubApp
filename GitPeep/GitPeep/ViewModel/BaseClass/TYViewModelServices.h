//
//  TYViewModelServices.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/3.
//  Copyright © 2018年 tianyao. All rights reserved.
//
// 继承自导航协议，申明一些公用属性

#import "TYNavigationProtocol.h"

@protocol TYViewModelServices <TYNavigationProtocol>

@required

@property (nonatomic, strong) OCTClient *client;

@end
