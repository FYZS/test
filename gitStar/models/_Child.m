//
//  Child.m
//  gitStar
//
//  Created by 凡义 on 2018/9/2.
//  Copyright © 2018年 凡义. All rights reserved.
//

#import "_Child.h"
#import "Person+protected.h"
#import <JRSwizzle/JRSwizzle.h>
#import <objc/runtime.h>

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

#pragma mark - testSwizzling
+ (void)load {
    
    Method superSayHelloMethod = class_getInstanceMethod([self superclass], @selector(sayHello));

    //获取父类的方法实现
    IMP superSayHelloIMP = method_getImplementation(superSayHelloMethod);
    BOOL rel = class_addMethod(self, @selector(sayHello), superSayHelloIMP, "v@:");
    NSLog(@"class_addMethod is %@", @(rel));
    
    Method sayHelloMethod = class_getInstanceMethod(self, @selector(sayHello));

    IMP sayHelloIMP = method_getImplementation(sayHelloMethod);
    NSLog(@"after class_addMethod is %@", @(sayHelloIMP == superSayHelloIMP));

    
//    [self jr_swizzleMethod:@selector(sayHello) withMethod:@selector(child_sayHello) error:nil];
}

- (void)child_sayHello {
    [self child_sayHello];
    
    NSLog(@"child test sayHello");
}

@end
