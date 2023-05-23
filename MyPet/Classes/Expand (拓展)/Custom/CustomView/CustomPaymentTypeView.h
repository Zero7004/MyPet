//
//  CustomPaymentTypeView.h
//  MyPet
//
//  Created by long on 2021/7/25.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CustomPaymentType) {
    CustomPaymentType_wechat = 1,   /// 微信
    CustomPaymentType_alipay,   /// 支付宝
    CustomPaymentType_other,    /// 代付
    CustomPaymentType_balance,   /// 余额支付
};

@interface CustomPaymentTypeView : BaseView

- (instancetype)initWith:(CustomPaymentType)type;

@property (nonatomic, copy) void(^PaymentTypeBlock)(CustomPaymentType type);

- (void)updateBgViewColor:(UIColor *)color;

@property (nonatomic, strong) NSString *selectIcon;

- (void)showOtherPayType;

@end

NS_ASSUME_NONNULL_END
