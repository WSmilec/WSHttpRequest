//
//  WSAPIHelper.h
//  WSHttpRequest
//
//  Created by WangS on 17/2/4.
//  Copyright © 2017年 WangS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSHttpRequest.h"

@interface WSAPIHelper : NSObject

+(void)accessJD:(NSDictionary *)params
     success:(WSHttpRequestSuccessBlock)success
     failure:(WSHttpRequestFailureCodeBlock)failure;
@end
