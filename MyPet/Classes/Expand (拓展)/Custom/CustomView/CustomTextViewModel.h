//
//  CustomTextViewModel.h
//  MyPet
//
//  Created by long on 2021/7/24.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CustomTextViewType) {
    CustomTextViewType_TF,   /// 输入框
    CustomTextViewType_Sel,  /// 选择按钮
    CustomTextViewType_Lab,  /// 文本
    CustomTextViewType_options,  /// 选项
};


@interface CustomTextViewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *valueKey;
@property (nonatomic, strong) NSString *titleColor;
@property (nonatomic, strong) NSString *valueColor;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, assign) BOOL addBottomLine;
@property (nonatomic, assign) CustomTextViewType viewType;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, strong) NSString *rightStr;
@property (nonatomic, assign) BOOL isHidden;
@property (nonatomic, assign) BOOL isNotMust;
@property (nonatomic, strong) NSArray *optionsArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL redStar;

@end

NS_ASSUME_NONNULL_END
