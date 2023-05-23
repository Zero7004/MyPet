//
//  DataModel.h
//  MyPet
//
//  Created by 王健龙 on 2019/7/6.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataModel : NSObject
/// 类型名称
@property (copy ,nonatomic) NSString *dictLabel;
/// 类型值
@property (copy ,nonatomic) NSString *dictValue;
/// 产品ID
@property (copy ,nonatomic) NSString *productId;
/// 标题
@property (copy ,nonatomic) NSString *title;
/// 0：银行产品； 1：机构产品
@property (copy ,nonatomic) NSString *classificationOne;
@end

NS_ASSUME_NONNULL_END
