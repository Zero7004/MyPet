//
//  PayModel.h
//  MyPet
//
//  Created by 王健龙 on 2020/4/29.
//  Copyright © 2020 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayModel : NSObject
/// vip等级
@property (strong ,nonatomic) NSString *vipLevel;
/// 开通时间
@property (strong ,nonatomic) NSString *vipTimes;
/// 金额
@property (strong ,nonatomic) NSString *amount;
/// 商家向财付通申请的商家id
@property (strong ,nonatomic) NSString *partnerId;
/// 由用户微信号和AppID组成的唯一标识，需要校验微信用户是否换号登录时填写
@property (strong ,nonatomic) NSString *appId;
/// 预支付订单
@property (strong ,nonatomic) NSString *prepayId;
/// 随机串，防重发
@property (strong ,nonatomic) NSString *nonceStr;
/// 时间戳，防重发
@property (strong ,nonatomic) NSString *timeStamp;
/// 商家根据财付通文档填写的数据和签名
@property (strong ,nonatomic) NSString *package;
/// 商家根据微信开放平台文档对数据做的签名
@property (strong ,nonatomic) NSString *paySign;
@end


@interface PayNewModel : MCBaseModel

/// 时间戳，防重发
@property (strong ,nonatomic) NSString *timeStamp;
/// 订单编号
@property (strong ,nonatomic) NSString *orderNo;
/// 商家根据财付通文档填写的数据和签名
@property (strong ,nonatomic) NSString *package;
/// 商家根据微信开放平台文档对数据做的签名
@property (strong ,nonatomic) NSString *paySign;
/// 由用户微信号和AppID组成的唯一标识，需要校验微信用户是否换号登录时填写
@property (strong ,nonatomic) NSString *appId;
///
@property (strong ,nonatomic) NSString *signType;
/// 商家向财付通申请的商家id
@property (strong ,nonatomic) NSString *partnerId;
/// 预支付订单
@property (strong ,nonatomic) NSString *prepayId;
/// 随机串，防重发
@property (strong ,nonatomic) NSString *nonceStr;

@end

NS_ASSUME_NONNULL_END
