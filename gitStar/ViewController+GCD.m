//
//  ViewController+GCD.m
//  gitStar
//
//  Created by 凡义 on 2018/10/16.
//  Copyright © 2018年 凡义. All rights reserved.
//

#import "ViewController+GCD.h"

@implementation ViewController (GCD)

#pragma mark - GCD
//串行队列并发任务
- (void)asyncInSerialQueue {
    NSLog(@"async thread:%@", [NSThread currentThread]);
    
    if(!self.globalQueue) {
        self.globalQueue = dispatch_queue_create("com.serial.queue", NULL);
        //        _globalQueue = dispatch_queue_create("com.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    }
    
    for (NSInteger i = 0; i < 20; i++) {
        dispatch_async(self.globalQueue, ^{
            NSLog(@"async in serial.queue:%td, thread:%@", i, [NSThread currentThread]);
        });
    }
}


@end
