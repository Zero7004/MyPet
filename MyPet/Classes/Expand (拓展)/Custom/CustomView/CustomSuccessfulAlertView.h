//
//  CustomSuccessfulAlertView.h
//  MyPet
//
//  Created by long on 2021/7/31.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomSuccessfulAlertView : BaseView

@property (nonatomic, copy) void(^ActionBlock)(void);
@property (nonatomic, copy) void(^CloseBlock)(void);

@property (nonatomic, strong) NSString *tipString;
@property (nonatomic, strong) NSString *btnString;

- (void)showAlertView;
- (void)hiddenAlertView;

@end

NS_ASSUME_NONNULL_END
