//
//  CustomDatePickerView.h
//  MyPet
//
//  Created by long on 2021/9/8.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DatePickerType) {
    DatePickerType_default, //默认
    DatePickerType_ymd,   //年月日
};


typedef void (^MyBlock) (NSString *timeString);
@interface CustomDatePickerView : UIView

- (instancetype)initWithStarTime:(NSString *)starTime EndTime:(NSString *)endTime;
@property (nonatomic, assign) DatePickerType pickerType;


@property(nonatomic, strong) MyBlock timeBlock;
@property (nonatomic, copy) void(^closeBlock)(void);

- (void)show;
- (void)hide;


@end

NS_ASSUME_NONNULL_END
