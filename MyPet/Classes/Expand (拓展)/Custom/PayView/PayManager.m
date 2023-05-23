//
//  PayManager.m
//  MyPet
//
//  Created by 王健龙 on 2020/4/29.
//  Copyright © 2020 王健龙. All rights reserved.
//

#import "PayManager.h"

@implementation PayManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static PayManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[PayManager alloc] init];
    });
    return instance;
}

+ (BOOL)handleOpenURL:(NSURL *)url delegate:(id<PayDelegate>)delegate {
   if ([url.host isEqualToString:@"safepay"]) {
       // 支付跳转支付宝钱包进行支付，处理支付结果
       [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
           NSInteger code = [resultDic[@"resultStatus"] integerValue];
           if ([PayManager sharedManager].delegate && [[PayManager sharedManager].delegate respondsToSelector:@selector(managerDidRecvPayResult:)]) {
               [[PayManager sharedManager] handleResult:code];
           }
       }];
    }
    
    return [WXApi handleOpenURL:url delegate:[self sharedManager]];
}

- (void)handleResult:(NSUInteger)code {
    switch (code) {
        case WXSuccess:
            [_delegate managerDidRecvPayResult:PaySuccess];
            break;
        case WXErrCodeUserCancel:
            [_delegate managerDidRecvPayResult:PayUserCancel];
            break;
        case WXErrCodeUnsupport:
            [_delegate managerDidRecvPayResult:PayUnsupported];
            break;
        case 9000:
            [_delegate managerDidRecvPayResult:PaySuccess];
            break;
        case 8000://正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
            [_delegate managerDidRecvPayResult:PaySuccess];
            break;
        case 5000://重复请求
            [_delegate managerDidRecvPayResult:PayProcessing];
            break;
        case 6001://用户中途取消
            [_delegate managerDidRecvPayResult:PayUserCancel];
            break;
        case 6002://网络连接出错
            [_delegate managerDidRecvPayResult:PayFailure];
            break;
        case 6004://支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
            [_delegate managerDidRecvPayResult:PayProcessing];
        break;
        default:
            [_delegate managerDidRecvPayResult:PayFailure];
            break;
    }
}

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
                   delegate:(id<PayDelegate>)delegate {
    
    if (![WXApi isWXAppInstalled]) {
        [SVProgressHUD showErrorWithStatus:@"请先安装微信"];
        return;
    }
    
    // 调起微信支付
    PayReq *req = [[PayReq alloc] init];
    req.openID = appid;
    /** 商家向财付通申请的商家id */
    req.partnerId = partnerId;
    /** 预支付订单 */
    req.prepayId = prepayId;
    /** 随机串，防重发 */
    req.nonceStr = nonceStr;
    /** 时间戳，防重发 */
    req.timeStamp = [timeStamp intValue];
    /** 商家根据财付通文档填写的数据和签名 */
    req.package = package;
    req.sign = sign;
    self.delegate = delegate;
    //日志输出
    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
}

/// 微信登录
/// @param scope 第三方程序要向微信申请认证，并请求某些权限，需要调用WXApi的sendReq成员函数，向微信终端发送一个SendAuthReq消息结构
/// @param state 三方程序本身用来标识其请求的唯一性，最后跳转回第三方程序时，由微信终端回传。
/// @param delegate 代理
- (void)wechatLoginScope:(NSString *)scope
                   state:(NSString *)state
                delegate:(id<PayDelegate>)delegate {
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = scope;
    req.state = state;
    self.delegate = delegate;
    [WXApi sendReq:req completion:nil];
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    // 微信支付
    if([resp isKindOfClass:[PayResp class]]){
        if (self.delegate && [self.delegate respondsToSelector:@selector(managerDidRecvPayResult:)]) {
            PayResp *payResp = (PayResp *)resp; 
            switch (payResp.errCode) {
                case WXSuccess:
                    [_delegate managerDidRecvPayResult:PaySuccess];
                    break;
                case WXErrCodeUserCancel:
                    [_delegate managerDidRecvPayResult:PayUserCancel];
                    break;
                case WXErrCodeUnsupport:
                    [_delegate managerDidRecvPayResult:PayUnsupported];
                    break;
                default:
                    [_delegate managerDidRecvPayResult:PayFailure];
                    break;
            }
        }
    } else if ([resp isMemberOfClass:[SendAuthResp class]]) { // 微信登录
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (aresp.errCode != 0) {
            [SVProgressHUD showErrorWithStatus:@"授权失败"];
        } else {
            NSString *code = aresp.code;
            if (self.delegate && [self.delegate respondsToSelector:@selector(managerDidRecvLoginResultCode:)]) {
                [_delegate managerDidRecvLoginResultCode:code];
            }
        }
    }
}

- (void)onReq:(BaseReq *)req {

}

@end
