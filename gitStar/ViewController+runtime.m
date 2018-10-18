//
//  ViewController+runtime.m
//  gitStar
//
//  Created by 凡义 on 2018/10/16.
//  Copyright © 2018年 凡义. All rights reserved.
//

#import "ViewController+runtime.h"
#import "AutoDictionary.h"

@implementation ViewController (runtime)

- (void)testAutoDictionary {
    AutoDictionary *dic = [[AutoDictionary alloc] init];
    dic.date = [NSDate date];
    NSLog(@"today is: %@", dic.date);
    NSLog(@"%@", dic);
}

@end
