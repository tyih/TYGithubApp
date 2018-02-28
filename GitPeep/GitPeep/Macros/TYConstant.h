//
//  TYConstant.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/3.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^VoidBlock)(void);
typedef int  (^IntBlock) (void);
typedef BOOL (^BoolBlock)(void);
typedef id   (^IdBlock)  (void);

typedef void (^VoidBlock_int)(int);
typedef int  (^IntBlock_int) (int);
typedef BOOL (^BoolBlock_int)(int);
typedef id   (^IdBlock_int)  (int);

typedef void (^VoidBlock_string)(NSString *);
typedef int  (^IntBlock_string) (NSString *);
typedef BOOL (^BoolBlock_string)(NSString *);
typedef id   (^IdBlock_string)  (NSString *);

typedef void (^VoidBlock_id)(id);
typedef int  (^IntBlock_id) (id);
typedef BOOL (^BoolBlock_id)(id);
typedef id   (^IdBlock_id)  (id);

@interface TYConstant : NSObject

@end
