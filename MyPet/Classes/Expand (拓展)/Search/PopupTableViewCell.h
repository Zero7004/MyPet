//
//  PopupTableViewCell.h
//  Loans_Users
//
//  Created by 王健龙 on 2019/5/30.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PopupTableViewCell : UITableViewCell

/// 模型
@property (copy ,nonatomic) PopupModel *popupModel;

- (void)isLastIndex:(BOOL)isLast;
@end

NS_ASSUME_NONNULL_END
