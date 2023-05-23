//
//  ShareView.h
//  MyPet
//
//  Created by 王健龙 on 2019/6/14.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShareView : BaseView
/// 分享链接
@property (strong ,nonatomic) NSString *shareLink;
/// 分享链接
@property (strong ,nonatomic) UIImage *image;
/// 分享标题
@property (strong ,nonatomic) NSString *title;
/// 分享描述
@property (strong ,nonatomic) NSString *desc;
@end

NS_ASSUME_NONNULL_END
