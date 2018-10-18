//
//  Person.m
//  gitStar
//
//  Created by 凡义 on 2018/9/2.
//  Copyright © 2018年 凡义. All rights reserved.
//

#import "Person.h"
#import "_Child.h"
#import "_Man.h"
#import "_Woman.h"

@implementation Person

//实现默认 alloc Child 的实力
+ (instancetype)alloc {
    return [Child alloc];
}

//通过调用super 保留真正alloc的能力
+(instancetype)_alloc {
    return [super alloc];
}

+(Person *)perponWithType:(PersonType)type {
    switch (type) {
        case PersonType_Child:
            return [Child new];
            break;
        case PersonType_Man:
            return [Man new];
            break;
        case PersonType_Woman:
            return [Woman new];
            break;
    }
}

- (void)doADaysWork {
    //should implement by subClass
}

@end
