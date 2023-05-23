//
//  SearchButtonView.h
//  Loans_Users
//
//  Created by 王健龙 on 2019/5/29.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SearchKeyModel;
@interface SearchButtonView : UIView

/// 被选中的标题
@property (strong ,nonatomic) NSString *selectTitle;
/// 被选中的类型
@property (strong ,nonatomic) NSString *type;
/// 搜索内容
@property (strong ,nonatomic) NSString *searchContentText;
/// 搜索内容回调
@property (copy ,nonatomic) void(^searchContentBlock)(SearchKeyModel *model);

- (instancetype)initWithFrame:(CGRect)frame selectTitle:(NSString *)selectTitle clikc:(void(^)(void))clikc;

@end

NS_ASSUME_NONNULL_END
