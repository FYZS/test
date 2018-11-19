//
//  UIView+hitTest.m
//  gitStar
//
//  Created by 凡义 on 2018/11/6.
//  Copyright © 2018 凡义. All rights reserved.
//

#import "UIView+hitTest.h"
#import <JRSwizzle/JRSwizzle.h>

@implementation UIView (hitTest)

+ (void)load {
    [self jr_swizzleMethod:@selector(pointInside:withEvent:) withMethod:@selector(fy_pointInside:withEvent:) error:nil];
    [self jr_swizzleMethod:@selector(hitTest:withEvent:) withMethod:@selector(fy_hitTest:withEvent:) error:nil];
}

- (BOOL)fy_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL rel = [self fy_pointInside:point withEvent:event];
    if(rel) {
        NSLog(@"hitTest:%@ can answer", self.class);
    }
    else {
        NSLog(@"hitTest:%@ can not answer", self.class);
    }
    return rel;
}

- (UIView *)fy_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [self fy_hitTest:point withEvent:event];
    NSLog(@"hitTest:hit view is %@, self is %@", view.class, self.class);
    return view;
}

@end

