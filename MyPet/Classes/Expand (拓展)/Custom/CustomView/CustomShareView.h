//
//  CustomShareView.h
//  MyPet
//
//  Created by long on 2021/7/27.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CustomShareType) {
    CustomShareType_wechat,   /// 微信好友
    CustomShareType_Circle,  /// 朋友圈
    CustomShareType_group,  /// 微信群
    CustomShareType_down,  /// 保存图片
};


@interface CustomShareView : BaseView

@property (nonatomic, copy) void(^ShareBlock)(CustomShareType shareType);

@end

NS_ASSUME_NONNULL_END
