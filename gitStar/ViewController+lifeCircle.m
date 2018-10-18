//
//  ViewController+lifeCircle.m
//  gitStar
//
//  Created by 凡义 on 2018/10/16.
//  Copyright © 2018年 凡义. All rights reserved.
//

#import "ViewController+lifeCircle.h"


@implementation ViewController (lifeCircle)

#pragma mark - VC生命周期
//加载控制器的视图, 只有在self.view=nil时会被调用, 应该由系统自动调用, 且可能会被调用多次
- (void)loadView {
    [super loadView];
    
    NSLog(@"lifecircle %s", __FUNCTION__);
}


- (void)refreshTableView {
    //清空之前的数据
    [self.numsArray removeAllObjects];
    
    //生成新数据
    for(NSInteger i = 0 ; i < self.maxNum; i++) {
        NSInteger num = random()%100;
        [self.numsArray addObject:@(num)];
    }
    
    //tableview reload
    [self.tableView reloadData];
}
//view即将显示
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"lifecircle %s", __FUNCTION__);
}

//即将对view的子视图进行布局
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    NSLog(@"lifecircle %s", __FUNCTION__);
}

//布局成功
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    NSLog(@"lifecircle %s", __FUNCTION__);
}

//展示视图
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"lifecircle %s", __FUNCTION__);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"lifecircle %s", __FUNCTION__);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"lifecircle %s", __FUNCTION__);
}

- (void)dealloc {
    NSLog(@"lifecircle %s", __FUNCTION__);
}

@end
