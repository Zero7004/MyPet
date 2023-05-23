//
//  FunctionCustomDM.h
//  MyPet
//
//  Created by long on 2022/7/20.
//  Copyright © 2022 王健龙. All rights reserved.
//

#import "MCBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FunctionItmeDM;

@interface FunctionCustomDM : MCBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray <FunctionItmeDM>*itmes;

@end

@interface FunctionItmeDM : MCSubBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *iconName;

@end


NS_ASSUME_NONNULL_END
