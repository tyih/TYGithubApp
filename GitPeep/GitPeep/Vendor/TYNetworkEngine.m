//
//  TYNetworkEngine.m
//  GitPeep
//
//  Created by tiany on 2018/2/28.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYNetworkEngine.h"

@implementation TYNetworkEngine

static TYNetworkEngine *sharedObj = nil; // 静态实例，并初始化

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObj = [[super allocWithZone:NULL] initWithHostName:@"api.github.com" customHeaderFields:@{@"Accept" : @"application/vnd.github.v3+json"}];
    });
    return sharedObj;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    return [self sharedInstance];
}

- (id)copy {
    
    return sharedObj;
}

- (id)mutableCopy {
    
    return sharedObj;
}


// Search Users
- (MKNetworkOperation *)searchUsersWithPage:(NSUInteger)page
                                          q:(NSString *)q
                                       sort:(NSString *)sort
                                   location:(NSString *)location
                                   language:(NSString *)language
                           completionHandle:(CompletionBlock)completionBlock
                                errorHandle:(ErrorBlock)errorBlock {
    
    NSString *path = [NSString stringWithFormat:@"search/users?q=%@&sort=%@&page=%ld", q, sort, page];
    MKNetworkOperation *operation = [self operationWithPath:path params:nil httpMethod:@"GET" ssl:YES];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        if ([[completedOperation responseJSON] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = [completedOperation responseJSON];
            completionBlock(resultDictionary);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        errorBlock(error);
    }];
    [self enqueueOperation:operation];
    return operation;
}

// UserDetail
- (MKNetworkOperation *)userDetailWithUserName:(NSString *)userName
                              completionHandle:(CompletionBlock)completionBlock
                                   errorHandle:(ErrorBlock)errorBlock {
    
    NSString *path = [NSString stringWithFormat:@"users/%@", userName];
    MKNetworkOperation *operation = [self operationWithPath:path params:nil httpMethod:@"GET" ssl:YES];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        if ([[completedOperation responseJSON] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = [completedOperation responseJSON];
            completionBlock(resultDictionary);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        errorBlock(error);
    }];
    [self enqueueOperation:operation];
    return operation;
}

@end
