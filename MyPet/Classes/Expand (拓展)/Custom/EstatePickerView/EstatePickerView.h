//
//  EstatePickerView.h
//  MyPet
//
//  Created by 王健龙 on 2019/7/18.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, PickerViewType) {
    /// 获取公司
    caseTypeList,
    /// 获取分公司
    caseTypeList2,
};
NS_ASSUME_NONNULL_BEGIN

@interface EstatePickerView : UIView
@property (nonatomic, copy) void(^didSelectItemBlock)(NSString *title, NSString *dataId);
@property (nonatomic, copy) void(^closeBlock)(void);

- (void)show;
- (void)hide;

- (instancetype)initWithType:(PickerViewType)type;
- (instancetype)initWithType:(PickerViewType)type CompanyId:(NSString *)companyId;
@end

NS_ASSUME_NONNULL_END
