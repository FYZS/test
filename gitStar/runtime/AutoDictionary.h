//
//  AutoDictionary.h
//  gitStar
//
//  Created by 凡义 on 2018/10/16.
//  Copyright © 2018年 凡义. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AutoDictionary : NSObject

@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) id anyObject;

@end

NS_ASSUME_NONNULL_END
