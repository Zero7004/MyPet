//
//  RegionPickerView.h
//  MyPet
//
//  Created by long on 2021/10/29.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN
@class RegionChildrenDataModel;
@interface RegionPickerView : BaseView

- (instancetype)initWithRegionData:(NSArray<RegionChildrenDataModel *> *)dataArray;

@property (nonatomic, copy) void(^didSelectItemBlock)(NSString *address, NSString *areaId);
@property (nonatomic, copy) void(^closeBlock)(void);

- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
