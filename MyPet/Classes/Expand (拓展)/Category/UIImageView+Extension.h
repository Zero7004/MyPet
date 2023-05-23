//
//  UIImageView+Extension.h
//  Tools
//
//  Created by 王健龙 on 2019/3/24.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Extension)

/**
 圆头像
 
 @param url url
 */
- (void)setCircleHeaderUrl:(NSString *)url;


/**
 圆头像
 
 @param url url
 @param placeholderImageName 占位图片
 */
- (void)setCirclHeaderUrl:(NSString *)url withplaceholderImageName:(NSString *)placeholderImageName;

/**
 普通图片
 
 @param url url
 */
- (void)setImageUrl:(NSString *)url;

/**
 普通图片
 
 @param url url
 @param placeholderImageName 占位图片
 */
- (void)setImageUrl:(NSString *)url withplaceholderImageName:(NSString *)placeholderImageName;

@end

NS_ASSUME_NONNULL_END
