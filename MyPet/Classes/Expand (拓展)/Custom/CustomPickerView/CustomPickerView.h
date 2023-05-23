//
//  CustomPickerView.h
//  MyPet
//
//  Created by long on 2021/8/9.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPickerViewModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PickerType) {
    PickerType_one,
    PickerType_two,
    PickerType_NOLinkage //不联动
};

@interface CustomPickerView : UIView

@property (nonatomic, copy) void(^didSelectItemBlock)(NSString *title, NSString *dataId);
@property (nonatomic, copy) void(^didSelectItemBlockSec)(NSString *title, NSString *dataId, NSString *title_2, NSString *dataId_2);
@property (nonatomic, copy) void(^closeBlock)(void);

- (void)show;
- (void)hide;

- (instancetype)initWithCustomArray:(NSArray *)array;

- (instancetype)initWithCustomArray:(NSArray *)array withPickerType:(PickerType)pickerType;

- (instancetype)initWithCustomArray:(NSArray *)arrayF Array:(NSArray *)arrayS withPickerType:(PickerType)pickerType;


@end

NS_ASSUME_NONNULL_END
