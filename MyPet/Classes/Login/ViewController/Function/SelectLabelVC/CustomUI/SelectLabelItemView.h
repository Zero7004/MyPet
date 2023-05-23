//
//  SelectLabelItemView.h
//  MyPet
//
//  Created by long on 2022/7/21.
//  Copyright © 2022 王健龙. All rights reserved.
//

#import "BaseView.h"
#import "SelectLabelDM.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectLabelItemView : BaseView

- (instancetype)initWithTitle:(NSString *)title Width:(CGFloat)width dataArray:(NSArray *)dataArray;
@property (nonatomic, assign) SelectLabelType selectType;

@end

NS_ASSUME_NONNULL_END
