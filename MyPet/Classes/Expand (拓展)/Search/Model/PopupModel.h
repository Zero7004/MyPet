//
//  PopupModel.h
//  Loans_Users
//
//  Created by 王健龙 on 2019/5/30.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopupModel : NSObject

/// 名称标题
@property (copy ,nonatomic) NSString *title;
/// 此处大概是一个索引
@property (copy ,nonatomic) NSString *index;
/// 是否选中
@property (assign ,nonatomic) BOOL isSelect;
@end

NS_ASSUME_NONNULL_END
