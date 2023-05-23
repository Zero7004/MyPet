//
//  BaseTabBarController.h
//  tool
//
//  Created by 王健龙 on 2019/3/15.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTabBarController : UITabBarController

- (NSInteger)getLastItemIndex;
- (void)setLastItemIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
