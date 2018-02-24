//
//  TYOAuthViewModel.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/23.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYOAuthViewModel.h"

@interface TYOAuthViewModel ()

@property (nonatomic, copy, readwrite) NSString *UUIDString;

@end

@implementation TYOAuthViewModel

- (void)initialize {
    
    [super initialize];
    
    self.title = @"OAuth2 Authorization Login";
    
    CFUUIDRef UUID = CFUUIDCreate(NULL);
    self.UUIDString = CFBridgingRelease(CFUUIDCreateString(NULL, UUID));
    CFRelease(UUID);
    
    NSString *URLString = [NSString stringWithFormat:@"https://github.com/login/oauth/authorize?client_id=%@&scope=%@&state=%@", TY_CLIENT_ID, @"user,repo", self.UUIDString];
    
    self.request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
}

@end
