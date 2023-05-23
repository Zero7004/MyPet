//
//  PopupView.h
//  Loans_Users
//
//  Created by 王健龙 on 2019/5/30.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PopupModel;
@interface PopupView : UIView

/// 选择数组
@property (strong ,nonatomic) NSMutableArray *selectArray;
/// 选中block
@property (copy ,nonatomic) void(^selectBlock)(PopupModel *popupModel,NSMutableArray *selectArray);
// 不显示
- (void)hide;
@end

NS_ASSUME_NONNULL_END
