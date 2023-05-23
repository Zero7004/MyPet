//
//  KLMJRefreshFooter.m
//  MyPet
//
//  Created by 王健龙 on 2019/5/30.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "KLMJRefreshFooter.h"

@implementation KLMJRefreshFooter

- (instancetype)init {
    if (self = [super init]) {
        self.automaticallyChangeAlpha = NO;
        self.triggerAutomaticallyRefreshPercent = 1.0;
//        self.onlyRefreshPerDrag = YES;
        [self setTitle:@"正在努力加载中" forState:MJRefreshStateRefreshing];
        [self setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
        [self setTitle:@"" forState:MJRefreshStateIdle];
    }
    return self;
}

@end
