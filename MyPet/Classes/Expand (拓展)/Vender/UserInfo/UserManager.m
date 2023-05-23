//
//  UserManager.m
//  MyPet
//
//  Created by 王健龙 on 2019/6/20.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "UserManager.h"
#import "UserInfoModel.h"

static  NSString *userLoginKey = @"userLoginKey";
static  NSString *userBankKey = @"userBankKey";
@implementation UserManager

/**
 获取当前用户信息
 
 @return UserInfoModel
 */
+ (UserInfoModel *)currentUser {
    NSDictionary *dict = [self getUserInfoDictionary];
    UserInfoModel *userInfoModel = [[UserInfoModel alloc] initWithDictionary:dict error:nil];
    return userInfoModel;
}

/**
 更新当前用户信息
 
 @param info UserInfoModel
 */
+ (void)saveCurrentUser:(UserInfoModel *)info {
    NSDictionary *infoDic = [info toDictionary];
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    [uDefault setObject:infoDic forKey:userLoginKey];
    [uDefault synchronize];
}


+ (BOOL)isLogin {
    UserInfoModel *uInfo = [self currentUser];
    return (uInfo&&([self currentUser].usertoken) ? YES : NO);
}

+ (NSMutableDictionary *)getUserInfoDictionary{
    NSUserDefaults *uDefault     = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *infoDic = [uDefault objectForKey:userLoginKey];
    return infoDic;
}

+ (NSMutableDictionary *)getUserBankInfo {
    NSUserDefaults *uDefault     = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *infoDic = [uDefault objectForKey:userBankKey];
    return infoDic;
}

+ (void)deleteUserInfo {
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    [uDefault removeObjectForKey:userLoginKey];
    [uDefault removeObjectForKey:userBankKey];
}


@end
