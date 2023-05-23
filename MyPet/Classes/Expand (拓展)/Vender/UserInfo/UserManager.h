//
//  UserManager.h
//  MyPet
//
//  Created by 王健龙 on 2019/6/20.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UserInfoModel;
@class MyBankModel;
@interface UserManager : NSObject
/**
 获取当前用户信息
 
 @return UserInfoModel
 */
+ (UserInfoModel *)currentUser;


/**
 更新当前用户信息
 
 @param info UserInfoModel
 */
+ (void)saveCurrentUser:(UserInfoModel *)info;



/**
 获取当前用户银行卡信息
 
 @return MyBankInfo
 */
+ (MyBankModel *)currentUserBankInfo;

/**
 更新提现过的银行卡信息
 
 @param bankModel bankModel
 */
+ (void)saveCurrentBank:(MyBankModel *)bankModel;

+ (BOOL)isLogin;

+ (void)deleteUserInfo;


@end

NS_ASSUME_NONNULL_END
