//
//  TYExploreCollectionViewCellViewModel.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/6.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYExploreCollectionViewCellViewModel : NSObject

@property (nonatomic, strong) id model;

@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) RACCommand *didSelectCommand;

@end
