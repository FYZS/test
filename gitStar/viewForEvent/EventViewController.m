//
//  EventViewController.m
//  gitStar
//
//  Created by 凡义 on 2018/11/6.
//  Copyright © 2018 凡义. All rights reserved.
//

#import "EventViewController.h"
#import "AView.h"
#import "BView.h"
#import "CView.h"
#import <Masonry/Masonry.h>

@interface EventViewController ()<UIGestureRecognizerDelegate>

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self touchEventTest];

    [self addGesture];
    
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)addGesture {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture)];
    gesture.delegate = self;
    gesture.numberOfTouchesRequired = 1;
//    [self.view addGestureRecognizer:gesture];
}

- (void)gesture {
    NSLog(@"hit : there was a gesture");
}

- (void)touchEventTest {
    AView *viewA = [[AView alloc] init];
    viewA.backgroundColor = [UIColor greenColor];
    BView *viewB = [[BView alloc] init];
    viewB.backgroundColor = [UIColor redColor];
    CView *viewC = [[CView alloc] init];
    viewC.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:viewA];
    [viewA addSubview:viewB];
    [self.view addSubview:viewC];
    
    [viewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(150);
        make.height.mas_equalTo(@(200));
    }];
    
    [viewB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.top.offset(50);
        make.height.mas_equalTo(@(50));
    }];

    [viewC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.top.mas_equalTo(viewA.mas_bottom).offset(50);
        make.height.mas_equalTo(@(100));
    }];
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

#pragma mark - touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"EventViewController touchBegin");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    NSLog(@"EventViewController touchesMoved");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"EventViewController touchesCancelled");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    NSLog(@"EventViewController touchesEnded");
}

@end
