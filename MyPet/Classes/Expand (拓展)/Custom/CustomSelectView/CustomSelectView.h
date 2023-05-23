//
//  CustomSelectView.h
//  MyPet
//
//  Created by long on 2021/9/13.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSelectViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomSelectView : UIView

- (instancetype)initWithTitle:(NSString *)title addData:(NSArray *)array textAlignment:(NSTextAlignment)textAlignment;

@property (nonatomic, copy) void(^didSelectItemBlock)(NSInteger index);
@property (nonatomic, copy) void(^closeBlock)(void);

- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
