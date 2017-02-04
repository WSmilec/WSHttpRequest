//
//  WSHttpRequestErrorHandler.h
//  WSHttpRequest
//
//  Created by WangS on 17/2/4.
//  Copyright © 2017年 WangS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSHttpRequestErrorHandler : NSObject
+(void)Error403:(NSInteger)code;
+(void)Error404:(NSInteger)code;
+(void)Error400:(NSInteger)code;
+(void)Error409:(NSInteger)code;
+(void)Error500:(NSInteger)code;
+(void)alert:(NSString *)message;
@end
