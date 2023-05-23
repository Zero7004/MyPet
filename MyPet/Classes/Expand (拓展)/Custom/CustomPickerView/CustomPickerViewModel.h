//
//  CustomPickerViewModel.h
//  MyPet
//
//  Created by long on 2021/8/9.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomPickerViewModel : NSObject

@property (copy ,nonatomic) NSString *title;
@property (copy ,nonatomic) NSString *value;
@property (copy ,nonatomic) NSArray <CustomPickerViewModel *>*valueArray;

@end

NS_ASSUME_NONNULL_END
