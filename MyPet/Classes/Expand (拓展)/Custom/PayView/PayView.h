//
//  PayView.h
//  MyPet
//
//  Created by 王健龙 on 2020/4/19.
//  Copyright © 2020 王健龙. All rights reserved.
//

#import "BaseView.h"
#import "PayModel.h"

typedef enum : NSUInteger {
    PayMentWexin = 0,
    PayMentAliPay,
    PayMentBalance,
} PayMent ;

typedef enum : NSUInteger {
    PayTypeAssessCount = 0,
    PayTypeAssessOrder,
    PayTypeMoneyRecharge,
    PayTypeOpneVip,
    PayTypeSearch,
    PayTypeCreditInvestigation,
} PayType ;
NS_ASSUME_NONNULL_BEGIN

@interface PayView : BaseView
/// 支付方式
@property (assign ,nonatomic) PayMent payMent;
/// 支付类型
@property (assign ,nonatomic) PayType payType;
/// 支付模型
@property (copy ,nonatomic) PayModel *payModel;
/// 是否隐藏余额支付
@property (assign ,nonatomic) BOOL isHideBalancePay;
/// 支付回调
@property (copy ,nonatomic) void(^payBlock)(BOOL isSuccess);
/// 充值会员回调
@property (copy ,nonatomic) void(^opneVipReply)(void);
@end

NS_ASSUME_NONNULL_END
