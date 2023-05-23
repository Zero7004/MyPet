//
//  BaseTableView.h
//  Tools
//
//  Created by 王健龙 on 2019/3/23.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableView : UITableView

/// 第几页
@property (assign ,nonatomic) NSInteger pageNum;
/// 数组
@property (strong ,nonatomic) NSMutableArray *modelArray;
/// id
@property (strong ,nonatomic) NSString *typeID;

- (void)tableViewLoadDataForRowCount:(NSUInteger)rowCount;
@end

NS_ASSUME_NONNULL_END
