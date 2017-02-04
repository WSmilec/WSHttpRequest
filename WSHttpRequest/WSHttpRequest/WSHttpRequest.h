//
//  WSHttpRequest.h
//  WSHttpRequest
//
//  Created by WangS on 17/2/4.
//  Copyright © 2017年 WangS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSHttpRequestErrorCode.h"
typedef NS_ENUM (NSInteger , WSHttpMethod){
    Get = 0,
    Post,
    Put,
    Delete
};
@interface WSHttpRequest : NSObject
typedef void (^WSHttpRequestSuccessBlock)(NSURLSessionDataTask *task, NSDictionary* data);
typedef void (^WSHttpRequestFailureBlock)(NSDictionary *dict, NSInteger statusCode);
typedef void (^WSHttpRequestFailureCodeBlock)(WSHttpRequestErrorCode *failure);

+ (void)urlRequestHandleWithFailureCode:(NSString *)url
                          headers:(NSDictionary *)headers
                           params:(NSDictionary *)params
                           method:(WSHttpMethod)method
                          success:(WSHttpRequestSuccessBlock)success
                          failure:(WSHttpRequestFailureCodeBlock)failure;
@end
