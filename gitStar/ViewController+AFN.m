//
//  ViewController+AFN.m
//  gitStar
//
//  Created by 凡义 on 2018/10/24.
//  Copyright © 2018年 凡义. All rights reserved.
//

#import "ViewController+AFN.h"
#import <AFNetworking/AFNetworking.h>


@implementation ViewController (AFN)

- (void)codeForAFN {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager POST:@"www.baidu.com" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"succes");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}

@end
