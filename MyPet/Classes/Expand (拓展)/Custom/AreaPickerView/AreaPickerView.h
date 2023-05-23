//
//  AreaPickerView.h
//  MyPet
//
//  Created by 王健龙 on 2019/6/27.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AreaPickerView : BaseView
@property (nonatomic, copy) void(^didSelectProvinceCityAreaAllBlock)(NSString *name, NSString *code);
@property (nonatomic, copy) void(^didSelectHouseBlock)(NSString *title, NSString *areaId);
@property (nonatomic, copy) void(^didSelectItemBlock)(NSString *title, NSString *areaId);
@property (nonatomic, copy) void(^didSelectCityAndAreaBlock)(NSString *cityTitle, NSString *cityId,NSString *areaTitle, NSString *areaId);
@property (nonatomic, copy) void(^didSelectAreaBlock)(NSString *title);
@property (nonatomic, copy) void(^closeBlock)(void);

- (void)show;
- (void)hide;

- (instancetype)initWithHouseCity;
- (instancetype)initWithArea;
- (instancetype)initWithGuangzhou;
// 评估价格选择城市
- (instancetype)initWithSelectProvinceCityAreaAll;
// 查册选择城市
- (instancetype)initWithSearchBooklet;
@end

NS_ASSUME_NONNULL_END
