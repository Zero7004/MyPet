//
//  FunctionCustomView.h
//  MyPet
//
//  Created by long on 2022/7/20.
//  Copyright © 2022 王健龙. All rights reserved.
//

#import "BaseView.h"
#import "FunctionCustomDM.h"
NS_ASSUME_NONNULL_BEGIN

@interface FunctionCustomView : BaseView

- (instancetype)initWithItemSize:(CGSize)itemSize
                           title:(NSString *)title;

- (void)setDataArray:(NSArray *)dataArray
           itemCount:(NSInteger)itemCount;

@property (copy ,nonatomic) void(^SelectBlock)(FunctionItmeDM *model);

@end

NS_ASSUME_NONNULL_END
