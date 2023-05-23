//
//  SearchKeyModel.h
//  Loans_Users
//
//  Created by 王健龙 on 2019/7/10.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchKeyModel : NSObject
/// 内容
@property (copy ,nonatomic) NSString *keyword;
/// 类型
@property (copy ,nonatomic) NSString *type;

@property (nonatomic, copy) NSString *hotSearchId;

@end

NS_ASSUME_NONNULL_END
