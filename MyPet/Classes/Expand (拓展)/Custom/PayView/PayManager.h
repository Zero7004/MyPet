//
//  PayManager.h
//  MyPet
//
//  Created by 王健龙 on 2020/4/29.
//  Copyright © 2020 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
typedef enum NSUInteger {
    /// 支付成功
    PaySuccess,
     /// 用户取消
    PayUserCancel,
    /// 支付失败
    PayFailure,
    /// 支付处理中
    PayProcessing,
    /// 没有安装客户端
    PayUnsupported,
} PayResult;
NS_ASSUME_NONNULL_BEGIN

@protocol PayDelegate <NSObject>
@optional
- (void)managerDidRecvPayResult:(PayResult)response;
- (void)managerDidRecvLoginResultCode:(NSString *)code;
@end


@interface PayManager : NSObject <PayDelegate>
/// 代理
@property (assign ,nonatomic) id<PayDelegate, NSObject> delegate;

+ (instancetype)sharedManager;


/// 处理第三方应用通过URL启动App时传递的数据
/// @param url 启动应用时传递过来的URL
/// @param delegate PayDelegate对象，用来接收触发的消息。
+ (BOOL)handleOpenURL:(NSURL *)url delegate:(id<PayDelegate>) delegate;


/// 微信支付
/// @param partnerId 商家向财付通申请的商家id
/// @param appid 由用户微信号和AppID组成的唯一标识，需要校验微信用户是否换号登录时填写
/// @param prepayId 随机串，防重发
/// @param nonceStr 时间戳，防重发
/// @param timeStamp 时间戳，防重发
/// @param package 商家根据财付通文档填写的数据和签名
/// @param sign 签名
/// @param delegate 代理
- (void)wechatPlayPartnerId:(NSString *)partnerId
                      Appid:(NSString *)appid
                   PrepayId:(NSString *)prepayId
                   NonceStr:(NSString *)nonceStr
                  timeStamp:(NSString *)timeStamp
                    Package:(NSString *)package
                       Sign:(NSString *)sign
                   delegate:(id<PayDelegate>)delegate;


/// 微信登录
/// @param scope 第三方程序要向微信申请认证，并请求某些权限，需要调用WXApi的sendReq成员函数，向微信终端发送一个SendAuthReq消息结构
/// @param state 三方程序本身用来标识其请求的唯一性，最后跳转回第三方程序时，由微信终端回传。
/// @param delegate 代理
- (void)wechatLoginScope:(NSString *)scope
                   state:(NSString *)state
                delegate:(id<PayDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
