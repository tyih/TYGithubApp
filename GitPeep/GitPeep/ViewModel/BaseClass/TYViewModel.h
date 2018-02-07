//
//  TYViewModel.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/3.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TYViewModelServices;

typedef NS_ENUM(NSUInteger, TYTitleViewType) {
    TYTitleViewTypeDefault,
    TYTitleViewTypeDoubleTitle,
    TYTitleViewTypeLoading,
};

@interface TYViewModel : NSObject

- (instancetype)initWithServices:(id<TYViewModelServices>)services params:(NSDictionary *)params;

@property (nonatomic, strong, readonly) id<TYViewModelServices> services;

@property (nonatomic, strong, readonly) NSDictionary *params;

@property (nonatomic, assign) TYTitleViewType titleViewType;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, strong, readonly) RACSubject *errors;
@property (nonatomic, strong, readonly) RACSubject *willDisappearSignal;

- (void)initialize;

@end
