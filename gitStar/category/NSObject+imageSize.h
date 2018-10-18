//
//  NSObject+imageSize.h
//  gitStar
//
//  Created by 凡义 on 2018/10/15.
//  Copyright © 2018年 凡义. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (imageSize)

- (CGSize)getImageSizeWithURL:(id)imageURL;

@end

NS_ASSUME_NONNULL_END
