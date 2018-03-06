//
//  TYExploreItemCellViewModel.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/3/6.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TYExploreCollectionViewCellViewModel.h"

@interface TYExploreItemCellViewModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray<NSArray<TYExploreCollectionViewCellViewModel *> *> *collectionCellViewModels;
@property (nonatomic, strong) RACCommand *seeAllCommand;

@end
