//
//  Child.m
//  gitStar
//
//  Created by 凡义 on 2018/9/2.
//  Copyright © 2018年 凡义. All rights reserved.
//

#import "_Child.h"
#import "Person+protected.h"

@implementation Child

+ (instancetype)alloc {
    return [super _alloc];
}

- (void)doADaysWork {
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 5.0* NSEC_PER_SEC);
    
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"");
    });
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"");
    });
    
}

@end
