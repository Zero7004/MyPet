//
//  KLMJRefreshHeader.m
//  MyPet
//
//  Created by 王健龙 on 2019/5/30.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "KLMJRefreshHeader.h"

@implementation KLMJRefreshHeader

- (instancetype)init {
    if (self = [super init]) {
        
        self.automaticallyChangeAlpha = YES;
        self.lastUpdatedTimeLabel.hidden = YES;
        [self setTitle:@"正在刷新..." forState:MJRefreshStateIdle];
        [self setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
        
        //初始化时开始刷新
        [self beginRefreshing];
    }
    return self;
}

@end
