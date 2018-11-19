//
//  ViewController+Operation.m
//  gitStar
//
//  Created by 凡义 on 2018/10/26.
//  Copyright © 2018 凡义. All rights reserved.
//

#import "ViewController+Operation.h"
#import <UIKit/UIKit.h>

@implementation ViewController (Operation)

- (void)doWithOperation {
    
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"first blockoperation");
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"add second blockoperation");
    }];
    
    [blockOperation isConcurrent];
    //    [blockOperation start];
    
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationSelector) object:self];
    
    //blockOperation依赖invocationOperation
    [blockOperation addDependency:invocationOperation];
    
    [operationQueue addOperation:blockOperation];
    [operationQueue addOperation:invocationOperation];
//    [operationQueue addOperations:@[invocationOperation] waitUntilFinished:NO];
//    [operationQueue waitUntilAllOperationsAreFinished];
}

- (void)invocationSelector {
    NSLog(@"NSInvocationOperation selector");
    
//    method_exchangeImplementations
//    class_replaceMethod
}
@end
