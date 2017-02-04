//
//  AFAppClient.h
//  WSHttpRequest
//
//  Created by WangS on 17/2/4.
//  Copyright © 2017年 WangS. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFAppClient : AFHTTPSessionManager
+(AFHTTPSessionManager *)shareClient;
@end
