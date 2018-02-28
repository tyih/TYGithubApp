//
//  TYNetworkEngine.h
//  GitPeep
//
//  Created by tiany on 2018/2/28.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <MKNetworkKit/MKNetworkKit.h>

typedef void(^CompletionBlock)(NSDictionary *responseDictionary);

typedef void(^ErrorBlock)(NSError *error);

@interface TYNetworkEngine : MKNetworkEngine

+ (instancetype)sharedInstance;

- (MKNetworkOperation *)searchUsersWithPage:(NSUInteger)page
                                          q:(NSString *)q
                                       sort:(NSString *)sort
                                   location:(NSString *)location
                                   language:(NSString *)language
                           completionHandle:(CompletionBlock)completionBlock
                                errorHandle:(ErrorBlock)errorBlock;

@end
