//
//  AutoDictionary.m
//  gitStar
//
//  Created by 凡义 on 2018/10/16.
//  Copyright © 2018年 凡义. All rights reserved.
//

#import "AutoDictionary.h"
#import <objc/runtime.h>

@interface AutoDictionary ()

@property (nonatomic, strong) NSMutableDictionary *backingStore;

@end

@implementation AutoDictionary

//@dynamic string, number, date, anyObject;

- (id)init {
    if( (self = [super init]) ) {
        _backingStore = [NSMutableDictionary new];
    }
    return self;
}

- (NSString *)description {
//    return [NSString stringWithFormat:@"description:<%@ : %p, %@>", [self class], self, self.backingStore];
    return [NSString stringWithFormat:@"<%@ : %p, \"%@, %@, %@ \" >", [self class], self, self.string, self.number, self.date];
}

- (NSString *)debugDescription {
//    return [NSString stringWithFormat:@"debugDescription:<%@ : %p, %@>", [self class], self, self.backingStore];
    return [NSString stringWithFormat:@"<%@ : %p, \"%@, %@, %@ \" >", [self class], self, self.string, self.number, self.date];
}

/*
#pragma mark - runtime
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selectorString = NSStringFromSelector(sel);
    
    if([selectorString hasPrefix:@"set"]) {
        class_addMethod(self, sel, (IMP)autoDictionarySetter, "v@:@");
    }
    else {
        class_addMethod(self, sel, (IMP)autoDictionaryGetter, "@@:");
    }
    return YES;
}

id autoDictionaryGetter(id self, SEL _cmd) {
    // 获取字典
    AutoDictionary *typedSelf = (AutoDictionary *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    
    //获取key值
    NSString *key = NSStringFromSelector(_cmd);
    
    return [backingStore objectForKey:key];
}

void autoDictionarySetter(id self, SEL _cmd, id value) {
    AutoDictionary *typedSelf = (AutoDictionary *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;

    //获取key值
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSMutableString *keyString = [selectorString mutableCopy];
    [keyString deleteCharactersInRange:NSMakeRange(keyString.length-1, 1)];
    
    [keyString deleteCharactersInRange:NSMakeRange(0, 3)];
    
    NSString *firtChar = [[keyString substringToIndex:1] lowercaseString];
    [keyString replaceCharactersInRange:NSMakeRange(0, 1) withString:firtChar];
    
    if(value) {
        [backingStore setValue:value forKey:keyString];
    }
    else {
        [backingStore removeObjectForKey:keyString];
    }
}
*/

@end
