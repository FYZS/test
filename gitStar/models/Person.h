//
//  Person.h
//  gitStar
//
//  Created by 凡义 on 2018/9/2.
//  Copyright © 2018年 凡义. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PersonType) {
    PersonType_Child = 0,
    PersonType_Man,
    PersonType_Woman
};

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger salary;

+ (Person *)perponWithType:(PersonType)type;

- (void)doADaysWork;

@property (nonatomic) void(^nblock)(int);

@end
