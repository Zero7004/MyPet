//
//  DataPickerView.h
//  MyPet
//
//  Created by 王健龙 on 2019/7/6.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, DataPickerViewType) {
    /// 获取案件类型 -买房按揭
    caseTypeList,
    /// 获取案件类型
    caseTypeList2,
    /// 获取房产证字号类型
    certificateTypeList,
    /// 是否
    therOrNot,
    /// 垫资类型
    advanceFundType,
    /// 抵押类型
    mortgageType,
    /// 自定义类型
    customType,
};

@interface DataPickerView : UIView
@property (nonatomic, copy) void(^didSelectItemBlock)(NSString *title, NSString *dataId);
@property (nonatomic, copy) void(^closeBlock)(void);

- (void)show;
- (void)hide;

- (instancetype)initWithType:(DataPickerViewType)type;
- (instancetype)initWithCustomArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
