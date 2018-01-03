//
//  TYConstant.h
//  GitPeep
//
//  Created by IGEN-TECH on 2018/1/3.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^voidBlock)(void);
typedef int  (^intBlock) (void);
typedef BOOL (^boolBlock)(void);
typedef id   (^idBlock)  (void);

typedef void (^voidBlock_int)(int);
typedef int  (^intBlock_int) (int);
typedef BOOL (^boolBlock_int)(int);
typedef id   (^idBlock_int)  (int);

typedef void (^voidBlock_string)(NSString *);
typedef int  (^intBlock_string) (NSString *);
typedef BOOL (^boolBlock_string)(NSString *);
typedef id   (^idBlock_string)  (NSString *);

@interface TYConstant : NSObject

@end
