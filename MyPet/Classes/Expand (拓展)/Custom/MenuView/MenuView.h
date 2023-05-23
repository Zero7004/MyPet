//
//  MenuView.h
//  MyPet
//
//  Created by 王健龙 on 2019/5/31.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuView : UIScrollView

/// 选中的索引
@property (assign ,nonatomic) NSInteger selectedSegmentIndex;

- (void)menuTitleArray:(NSArray *)titleArray indexBlock:(void(^)(NSInteger index))indexBlock;

- (void)menuTitle2Array:(NSArray *)titleArray indexBlock:(void(^)(NSInteger index))indexBlock;

- (void)menuTitle3Array:(NSArray *)titleArray indexBlock:(nonnull void (^)(NSInteger))indexBlock;

@end

NS_ASSUME_NONNULL_END
