//
//  ApplePay.h
//  MyPet
//
//  Created by lzf on 2020/7/14.
//  Copyright © 2020 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    SIAPPurchSuccess = 0,       // 购买成功
    SIAPPurchFailed = 1,        // 购买失败
    SIAPPurchCancle = 2,        // 取消购买
    SIAPPurchVerFailed = 3,     // 订单校验失败
    SIAPPurchVerSuccess = 4,    // 订单校验成功
    SIAPPurchNotArrow = 5,      // 不允许内购
}SIAPPurchType;
 
typedef void (^IAPCompletionHandle)(SIAPPurchType type,NSData *data);

@interface ApplePay : NSObject
+ (instancetype)shareSIAPManager;
//开始内购
- (void)startPurchWithID:(NSString *)purchID completeHandle:(IAPCompletionHandle)handle;
@end

NS_ASSUME_NONNULL_END
