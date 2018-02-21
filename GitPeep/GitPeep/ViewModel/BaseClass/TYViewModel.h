//
//  TYViewModel.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/3.
//  Copyright © 2018年 tianyao. All rights reserved.
//
// 基础ViewModel类，定义初始化方法、属性、信号

#import <Foundation/Foundation.h>

@protocol TYViewModelServices;

typedef NS_ENUM(NSUInteger, TYTitleViewType) {
    TYTitleViewTypeDefault,
    TYTitleViewTypeDoubleTitle,
    TYTitleViewTypeLoading,
};

@interface TYViewModel : NSObject

/// 初始化方法
- (instancetype)initWithServices:(id<TYViewModelServices>)services params:(NSDictionary *)params;

/// 协议(跳转)实例
@property (nonatomic, strong, readonly) id<TYViewModelServices> services;

/// 参数(显示数据\格式)
@property (nonatomic, strong, readonly) NSDictionary *params;
@property (nonatomic, assign) TYTitleViewType titleViewType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

/// 信号(错误\消失)
@property (nonatomic, strong, readonly) RACSubject *errors;
@property (nonatomic, strong, readonly) RACSubject *willDisappearSignal;

- (void)initialize;

@end
