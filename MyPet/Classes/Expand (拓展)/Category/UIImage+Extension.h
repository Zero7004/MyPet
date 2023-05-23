//
//  UIImage+Extension.h
//  MyPet
//
//  Created by 王健龙 on 2019/6/12.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

- (instancetype)circleImage;

/// 根据颜色生成纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
