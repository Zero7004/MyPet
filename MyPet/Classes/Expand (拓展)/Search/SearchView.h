//
//  SearchView.h
//  Loans_Users
//
//  Created by 王健龙 on 2019/5/29.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchView : UIView

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder clikc:(void(^)(void))clikc;

- (void)viewZoomWithContentOffset:(CGFloat)contentOffset;

@end

NS_ASSUME_NONNULL_END
