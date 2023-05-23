//
//  PayTableViewCell.h
//  MyPet
//
//  Created by 王健龙 on 2020/4/29.
//  Copyright © 2020 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayTableViewCell : UITableViewCell
/// 图标
@property (strong ,nonatomic) UIImageView *iconImageView;
/// 标题
@property (strong ,nonatomic) UILabel *titleLabel;
/// 是否选中
@property (assign ,nonatomic) BOOL isSelect;
@end

NS_ASSUME_NONNULL_END
