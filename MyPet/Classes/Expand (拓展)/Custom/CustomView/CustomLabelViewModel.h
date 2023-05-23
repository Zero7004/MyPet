//
//  CustomLabelViewModel.h
//  MyPet
//
//  Created by long on 2021/7/25.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomLabelViewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *valueFont;
@property (nonatomic, strong) NSString *titleColor;
@property (nonatomic, strong) NSString *valueColor;
@property (nonatomic, assign) BOOL bottomLine;
@property (nonatomic, assign) CGFloat space;
@property (nonatomic, strong) NSString *titleIcon;
@property (nonatomic, strong) NSString *valueIcon;

@end

NS_ASSUME_NONNULL_END
