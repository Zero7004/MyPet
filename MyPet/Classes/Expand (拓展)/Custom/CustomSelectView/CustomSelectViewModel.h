//
//  CustomSelectViewModel.h
//  MyPet
//
//  Created by long on 2021/9/13.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "MCBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomSelectViewModel : MCBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
