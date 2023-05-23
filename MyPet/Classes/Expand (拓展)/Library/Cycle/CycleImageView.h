//
//  CycleImageView.h
//  CycleIMG
//
//  Created by Rainy on 2017/12/28.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MovementDirectionType) {
    
    MovementDirectionForHorizontally = 0,
    MovementDirectionVertically,
};

@protocol CycleImageViewDelegate <NSObject>

@optional
- (void)didSelectItemAtIndex:(NSInteger)index;

@end

@interface CycleImageView : UIView

@property(nonatomic,weak)id<CycleImageViewDelegate> delegate;

@property(nonatomic,assign)MovementDirectionType movementDirection;

@property(nonatomic,strong)NSArray *images;

@property(nonatomic,assign)NSTimeInterval timeInterval;

@property(nonatomic,assign)BOOL hidePageControl;

@property(nonatomic,assign)BOOL canFingersSliding;

@property(nonatomic,assign)BOOL canAutoSliding;  //是否自动滚动

@property(nonatomic,assign)BOOL canInfiniteSliding;  //是否能无限滚动

@property (nonatomic, copy) void(^didSelectItemBlock)(NSInteger index);

@end
