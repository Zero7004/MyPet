//
//  CustomButtonView.h
//  MyPet
//
//  Created by long on 2021/7/24.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, CustomButtonViewType) {
    CustomButtonView_def,       /// 默认：蓝色
    CustomButtonView_gray,      /// 灰色
    CustomButtonView_while,     /// 白色
    CustomButtonView_coudown,   /// 倒计时
};

@interface CustomButtonView : BaseView

@property (nonatomic, copy) void(^ButtonClickBlock)(void);

- (instancetype)initViewWithButtonType:(CustomButtonViewType)buttonType
                                String:(NSString *)string;

- (instancetype)initViewWithButtonType:(CustomButtonViewType)buttonType
                                String:(NSString *)string
                             TimeIndex:(NSInteger)timeIndex;

- (void)setButtonTtileFont:(UIFont *)font;

- (void)setButtonTtile:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
