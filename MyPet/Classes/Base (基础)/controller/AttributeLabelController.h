//
//  AttributeLabelController.h
//  MyPet
//
//  Created by 王健龙 on 2020/12/29.
//  Copyright © 2020 王健龙. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger, AttributeLabelType) {
    /// 推荐项目
    AttributeLabelTypeRecommendable = 0,
    /// 评估规则
    AttributeLabelTypeAssessmentRule,
    /// 邀请规则
    AttributeLabelTypeInvitationRule,
    /// 关于我们
    AttributeLabelTypeAboutUs,
    /// 隐私条款
    AttributeLabelTypePrivacyPolicy,
    /// 充值规则
    AttributeLabelTypRechargeRule,
};
NS_ASSUME_NONNULL_BEGIN

@interface AttributeLabelController : BaseViewController
@property (nonatomic, assign) AttributeLabelType type;
@end

NS_ASSUME_NONNULL_END
