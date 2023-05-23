//
//  CustomTextView.h
//  MyPet
//
//  Created by long on 2021/7/24.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "BaseView.h"
#import "CustomTextViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomTextView : BaseView

- (instancetype)initWithCustomTextViewModel:(CustomTextViewModel *)model;

@property (nonatomic, strong) CustomTextViewModel *model;

@property (nonatomic, copy) void(^TextViewClickBlock)(void);
@property (nonatomic, copy) void(^SelectClickBlock)(NSInteger status);
@property (nonatomic, copy) void(^TextFieldEndEditBlock)(NSString *string);

- (void)updateCustomTextView:(NSString *)valueStr;

- (void)updateCustomValue:(NSString *)valueStr valueKey:(NSString *)valueKey;
- (void)updateCustomTextFieldView:(NSString *)valueStr;

- (void)updateCustomTitleView:(NSString *)titleStr;
- (void)updateCustomValue:(NSString *)valueStr;

@end

NS_ASSUME_NONNULL_END
