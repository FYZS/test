//
//  ViewController.h
//  gitStar
//
//  Created by 凡义 on 2018/4/23.
//  Copyright © 2018年 凡义. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController 

@property (nonatomic, strong) NSMutableArray<NSString *> *array;
@property (nonatomic, copy) NSString *testTitle;

@property (nonatomic, strong) CALayer *backgroundLayer;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *numsArray;
@property (nonatomic, assign) NSInteger maxNum;

//GCD
@property (nonatomic, strong) dispatch_queue_t globalQueue;

@end

