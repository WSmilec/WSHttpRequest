//
//  WSHttpRequestErrorHandler.m
//  WSHttpRequest
//
//  Created by WangS on 17/2/4.
//  Copyright © 2017年 WangS. All rights reserved.
//

#import "WSHttpRequestErrorHandler.h"

@implementation WSHttpRequestErrorHandler
+(void)Error403:(NSInteger)code{

}
+(void)Error404:(NSInteger)code{

}
+(void)Error400:(NSInteger)code{

}
+(void)Error409:(NSInteger)code{

}
+(void)Error500:(NSInteger)code{
    switch (code) {
        case 14:
            //服务器内部错误
            break;
        default:
            break;
    }
}
+(void)alert:(NSString *)message{

}
@end
