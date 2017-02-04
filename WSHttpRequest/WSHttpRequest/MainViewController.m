//
//  MainViewController.m
//  WSHttpRequest
//
//  Created by WangS on 17/2/4.
//  Copyright © 2017年 WangS. All rights reserved.
//

#import "MainViewController.h"
#import "WSAPIHelper.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self addData];
}
- (void)addData{
    [WSAPIHelper accessJD:nil success:^(NSURLSessionDataTask *task, NSDictionary *data) {
        NSLog(@"data----- %@",data);
    } failure:^(WSHttpRequestErrorCode *failure) {
        NSLog(@"httpStatusCode---- %ld",(long)failure.httpStatusCode);
        NSLog(@"apiCode---- %ld",(long)failure.apiCode);
    }];
}


@end
