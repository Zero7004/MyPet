//
//  CustomSelectViewCell.h
//  MyPet
//
//  Created by long on 2021/9/13.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CustomSelectViewModel;
@interface CustomSelectViewCell : UITableViewCell

@property (nonatomic, strong) CustomSelectViewModel *model;
@property (nonatomic, assign) NSTextAlignment titleTextAlignment;

@end

NS_ASSUME_NONNULL_END
