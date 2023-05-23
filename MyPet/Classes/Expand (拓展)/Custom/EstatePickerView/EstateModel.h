//
//  EstateModel.h
//  MyPet
//
//  Created by 王健龙 on 2019/7/18.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EstateModel : NSObject
/// 所属公司ID
@property (copy ,nonatomic) NSString *companyId;
/// 公司名称
@property (copy ,nonatomic) NSString *intermediaryInstitutions;
/// 公司id
@property (copy ,nonatomic) NSString *estateId;
@end

NS_ASSUME_NONNULL_END
