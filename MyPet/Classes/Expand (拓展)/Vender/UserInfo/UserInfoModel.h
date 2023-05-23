//
//  UserInfoModel.h
//  MyPet
//
//  Created by 王健龙 on 2019/6/20.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCBaseModel.h"
#import "MCSubBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface order : MCSubBaseModel
/// 订单ID
@property (nonatomic, copy) NSString *orderId;
/// 案件号
@property (copy ,nonatomic) NSString *caseNumber;
/// 物业地址
@property (nonatomic, copy) NSString *realEstate;
/// 贷款类型
@property (nonatomic, copy) NSString *loanType;
/// 进度
@property (nonatomic, copy) NSString *caseProgressName;
@end

@interface UserInfo : MCSubBaseModel
/// 用户ID
@property (nonatomic, copy) NSString *id;
/// 用户ID
@property (nonatomic, copy) NSString *customerId;
/// 用户昵称
@property (nonatomic, copy) NSString *nickName;
/// 手机号码
@property (nonatomic, copy) NSString *mobile;
/// 头像
@property (nonatomic, copy) NSString *headImg;
/// 性别 1: 男, 2: 女, 3: 保密
@property (nonatomic, copy) NSString *sex;
/// 登录方式
@property (nonatomic, copy) NSString *loginType;


/// 邀请码
@property (nonatomic, copy) NSString *ivtcode;
/// 用户类型 1:普通用户 2:自由经纪人 3:机构经纪人
@property (nonatomic, copy) NSString *userType;
/// 所属公司ID
@property (nonatomic, copy) NSString *estateCompanyId;
/// 所属公司名称
@property (nonatomic, copy) NSString *estateCompanyName;
/// 所属分店ID
@property (nonatomic, copy) NSString *branchId;
/// 所属分店名
@property (nonatomic, copy) NSString *branchName;
/// 真实姓名
@property (nonatomic, copy) NSString *realName;
/// 1：正在审核；2：审核成功
@property (nonatomic, copy) NSString *state;
@end

@class MyBankModel;
@interface UserInfoModel : MCBaseModel
/// usertoken
@property (nonatomic, copy) NSString *usertoken;
/// 用户基础信息
@property (nonatomic, strong) UserInfo *userInfo;
/// 最新一条订单基础信息
@property (nonatomic, strong) order *order;
/// 邀请人数
@property (nonatomic, assign) NSInteger inviteCount;
/// 联系人数
@property (nonatomic, assign) NSInteger contactCount;
/// 可提现收益
@property (nonatomic, copy) NSString *money;
/// 余额
@property (nonatomic, copy) NSString *amount;
/// 会员 vip代理等级(0.普通用户 1.一级代理 2.二级代理 3.三级代理 4.月度会员 5.季度会员 6.年度会员)
@property (nonatomic, copy) NSString *vip; 
/// 订单数
@property (nonatomic, assign) NSInteger detailedNum;
/// 下月收益
@property (nonatomic, copy) NSString *nextMonthAgentOrderIncome;
/// 本月收益
@property (nonatomic, copy) NSString *thisMonthOrderIncomeSum;
/// 累计
@property (nonatomic, copy) NSString *totalRevenue;
/// 提醒
@property (nonatomic, copy) NSString *remind;
/// 会员到期时间
@property (nonatomic, copy) NSString *endTime;
/// 提现的银行卡
//@property (nonatomic, strong) MyBankModel *bankModel;
@end

NS_ASSUME_NONNULL_END
