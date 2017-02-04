//
//  WSHttpRequestErrorCode.h
//  WSHttpRequest
//
//  Created by WangS on 17/2/4.
//  Copyright © 2017年 WangS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSHttpRequestErrorCode : NSObject
@property (nonatomic,assign) NSInteger httpStatusCode;
@property (nonatomic,assign) NSInteger apiCode;
@end
