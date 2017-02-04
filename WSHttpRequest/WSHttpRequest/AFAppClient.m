//
//  AFAppClient.m
//  WSHttpRequest
//
//  Created by WangS on 17/2/4.
//  Copyright © 2017年 WangS. All rights reserved.
//

#import "AFAppClient.h"

@implementation AFAppClient
+(AFHTTPSessionManager *)shareClient{
    static AFHTTPSessionManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] initWithBaseURL:nil];
    });
    return instance;
}
@end
