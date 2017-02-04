//
//  WSHttpRequest.m
//  WSHttpRequest
//
//  Created by WangS on 17/2/4.
//  Copyright © 2017年 WangS. All rights reserved.
//

#import "WSHttpRequest.h"
#import "AppDelegate.h"
#import "AFAppClient.h"
#import "WSHttpRequestErrorHandler.h"

#define HTTP_CONNECTION_TIMEOUT 15

NSString *StringFromHttpMethod(WSHttpMethod method) {
    switch (method) {
        case Get:
            return @"GET";
        case Post:
            return @"POST";
        case Put:
            return @"PUT";
        case Delete:
            return @"DELETE";
    }
}
@implementation WSHttpRequest
+ (void)requestWhitUrl:(NSString *)url
               headers:(NSMutableDictionary *)headers
                params:(NSDictionary *)params
                method:(WSHttpMethod)method
               success:(WSHttpRequestSuccessBlock)success
               failure:(WSHttpRequestFailureBlock)failure{
    AFHTTPSessionManager *manager=[AFAppClient shareClient];
    manager.requestSerializer.timeoutInterval=HTTP_CONNECTION_TIMEOUT;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    if (headers) {
        for (NSString *key in headers) {
            [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }else{
        [manager.requestSerializer setValue:nil forHTTPHeaderField:@"Authorization"];
    }
    if(method == Get){
        [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(task, responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self failure:task error:error failure:failure];
        }];
    }else if(method == Post){
        [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(task, responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self failure:task error:error failure:failure];
        }];
    }else if(method == Put){
        [manager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(task, responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self failure:task error:error failure:failure];
        }];
    }else if(method == Delete){
        [manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(task, responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self failure:task error:error failure:failure];
        }];
    }
}
+ (void)failure:(NSURLSessionDataTask * _Nullable) task error:(NSError * _Nonnull) error failure:(WSHttpRequestFailureBlock)failure{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)task.response;
    NSInteger responseStatusCode = [httpResponse statusCode];
    NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    NSDictionary *dict = nil;
    if (data) {
        dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }
    if (failure) {
        failure(dict ,responseStatusCode);
    }
}
+ (void)requestWithUrlAndFailureCode:(NSString *)url
               headers:(NSDictionary *)headers
                params:(NSDictionary *)params
                method:(WSHttpMethod)method
               success:(WSHttpRequestSuccessBlock)success
               failure:(WSHttpRequestFailureCodeBlock)failure{
    // 设置头信息
    /*
    if (ApplicationDelegate && ApplicationDelegate.Basic) {
        if (!headers) {
            headers = [[NSMutableDictionary alloc]init];
        }
        [headers setValue:[NSString stringWithFormat:@"Basic %@",ApplicationDelegate.Basic] forKey:@"Authorization"];
    }
   */
    [self requestWhitUrl:url
                          headers:nil
                           params:params
                           method:method success:^(NSURLSessionDataTask *task,  NSDictionary *data){
                               if (success){
                                   success(task, data);
                               }                           }
                          failure:^(NSDictionary *data, NSInteger statusCode) {
                              // 业务层状态码
                              NSLog(@"%@",data);
                              NSInteger code = -1;
                              if (data) {
                                  code =[data[@"code"] integerValue];
                              }
                              if (failure) {
                                  WSHttpRequestErrorCode *errorResult=[[WSHttpRequestErrorCode alloc] init];
                                  errorResult.httpStatusCode=statusCode;
                                  errorResult.apiCode=code;
                                  failure(errorResult);
                              }
                          }];
}

+ (void)urlRequestHandleWithFailureCode:(NSString *)url
                          headers:(NSDictionary *)headers
                           params:(NSDictionary *)params
                           method:(WSHttpMethod)method
                          success:(WSHttpRequestSuccessBlock)success
                          failure:(WSHttpRequestFailureCodeBlock)failure{
    [self requestWithUrlAndFailureCode:url headers:headers params:params method:method success:^(NSURLSessionDataTask *task,  NSDictionary *data) {
        if (success){
            success(task, data);
        }
    } failure:^(WSHttpRequestErrorCode *error) {
        switch (error.httpStatusCode) {
            case 403:
                [WSHttpRequestErrorHandler Error403:error.apiCode];
                break;
            case 404:
                [WSHttpRequestErrorHandler Error404:error.apiCode];
                break;
            case 400:
                [WSHttpRequestErrorHandler Error400:error.apiCode];
                break;
            case 409:
                [WSHttpRequestErrorHandler Error409:error.apiCode];
                break;
            case 500:
                [WSHttpRequestErrorHandler Error500:error.apiCode];
                break;
            default:
                break;
        }
        if (failure){
            failure(error);
        }
    }];

}
@end
