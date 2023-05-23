//
//  LabelView.h
//  Loans_Users
//
//  Created by 王健龙 on 2019/5/29.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    hotLabelType = 0,
    historyLabelType
} labelType;

NS_ASSUME_NONNULL_BEGIN

@class SearchKeyModel;
@interface LabelView : UIView

/// 选中标签的名字
@property (nonatomic, copy) void(^delectHistoryLabelBlock)(void);
/// 选中标签的名字
@property (nonatomic, copy) void(^selectLabelBlock)(SearchKeyModel *searchKeyModel);

//- (instancetype)initWithFrame:(CGRect)frame type:(labelType)type labelArray:(NSArray *)labelArray;
- (instancetype)initWithType:(labelType)type labelArray:(NSArray *)labelArray;

@end

NS_ASSUME_NONNULL_END
