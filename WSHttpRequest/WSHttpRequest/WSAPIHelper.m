//
//  WSAPIHelper.m
//  WSHttpRequest
//
//  Created by WangS on 17/2/4.
//  Copyright © 2017年 WangS. All rights reserved.
//

#import "WSAPIHelper.h"
@implementation WSAPIHelper

+(void)accessJD:(NSDictionary *)params
     success:(WSHttpRequestSuccessBlock)success
     failure:(WSHttpRequestFailureCodeBlock)failure{
    NSString *url = @"https://github.com/WSmilec";
    [WSHttpRequest urlRequestHandleWithFailureCode:url headers:nil params:params method:Get success:success failure:failure];
}
@end
