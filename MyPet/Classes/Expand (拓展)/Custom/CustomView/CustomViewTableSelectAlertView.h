//
//  CustomViewTableSelectAlertView.h
//  MyPet
//
//  Created by long on 2021/8/2.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomSelModel : NSObject
/// 名称标题
@property (copy ,nonatomic) NSString *title;
/// 是否选中
@property (assign ,nonatomic) BOOL isSelect;
@end



@interface CustomViewTableSelectAlertView : BaseView

- (instancetype)initTitle:(NSString *)title dataArray:(NSArray *)dataArray;

@property (nonatomic, copy) void(^SelectBlock)(NSInteger);

- (void)showAlertView;
- (void)hiddenAlertView;

@end



NS_ASSUME_NONNULL_END
