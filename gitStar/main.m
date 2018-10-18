//
//  main.m
//  gitStar
//
//  Created by 凡义 on 2018/4/23.
//  Copyright © 2018年 凡义. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <objc/runtime.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {

        NSString *string = @"string";
        void (^block)(void);
        
        for (int i = 0; i < 1; i++) {
            block = ^ {
                NSLog(@"block %d", i);
            };
        }
        
        block();

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

