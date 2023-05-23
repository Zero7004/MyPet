//
//  BaseTableView.m
//  Tools
//
//  Created by 王健龙 on 2019/3/23.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "BaseTableView.h"

@interface BaseTableView ()

@end

@implementation BaseTableView

- (instancetype)init {
    if (self = [super init]) {
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}

- (void)config {
    //tableView 新特性 参考：http://www.jianshu.com/p/370d82ba3939
    [self setBackgroundColor:[UIColor clearColor]];
    [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    [self setTableFooterView:[UIView new]];
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
}

- (void)tableViewLoadDataForRowCount:(NSUInteger)rowCount {
    if (rowCount == 0) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, 130, 130);
        imageView.center = bgView.center;
        [imageView setImage:[UIImage imageNamed:@"nodata"]];
        [bgView addSubview:imageView];
        self.backgroundView = bgView;
    } else {
        self.backgroundView = nil;
    }
}

- (void)setPageNum:(NSInteger )pageNum {
    _pageNum = pageNum;
}

- (void)setModelArray:(NSMutableArray *)modelArray {
    _modelArray = modelArray;
}

- (void)setTypeID:(NSString *)typeID {
    _typeID = typeID;
}
@end
