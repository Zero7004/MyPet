//
//  CustomLabelView.h
//  MyPet
//
//  Created by long on 2021/7/25.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "BaseView.h"
#import "CustomLabelViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomLabelView : BaseView

- (instancetype)initWithDataModel:(CustomLabelViewModel *)model;

@end

NS_ASSUME_NONNULL_END
