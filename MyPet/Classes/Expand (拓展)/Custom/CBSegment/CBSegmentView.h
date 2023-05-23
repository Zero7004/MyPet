//
//  CBSegmentView.h
//  CBSegment
//
//  Created by 陈彬 on 2017/9/9.
//  Copyright © 2017年 com.bingo.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^titleChooseBlock)(NSInteger x);

typedef NS_ENUM(NSInteger, CBSegmentStyle) {
    /**
     * By default, there is a slider on the bottom.
     */
    CBSegmentStyleSlider = 0,
    /**
     * This flag will zoom the selected text label.
     */
    CBSegmentStyleZoom   = 1,
    
    /**
     *  custom
     */
    CBSegmentStyleCustom = 2,
};

@interface CBSegmentView : UIScrollView

@property (nonatomic, copy) titleChooseBlock titleChooseReturn;
/**
 * Set segment titles and titleColor.
 *
 * @param titleArray The titles segment will show.
 */
- (void)setTitleArray:(NSArray<NSString *> *)titleArray;

/**
 * Set segment titles and titleColor.
 *
 * @param titleArray The titles segment will show.
 * @param style The segment style.
 */
- (void)setTitleArray:(NSArray<NSString *> *)titleArray withStyle:(CBSegmentStyle)style;

/**
 * Set segment titles and titleColor.
 *
 * @param titleArray The titles segment will show.
 * @param titleColor The normal title color.
 * @param selectedColor The selected title color.
 * @param style The segment style.
 */
- (void)setTitleArray:(NSArray<NSString *> *)titleArray
            titleFont:(UIFont *)titleFont
      titleSelectFont:(UIFont *)titleSelectFont
           titleColor:(UIColor *)titleColor
   titleSelectedColor:(UIColor *)selectedColor
            withStyle:(CBSegmentStyle)style;
                
- (void)setSelectIndex:(NSInteger)index;

//更新底部横线UI
- (void)updateSliderUIWith:(CGFloat)width
                    height:(CGFloat)height
                     color:(UIColor *)color
              cornerRadius:(CGFloat)cornerRadius;

//更新按钮布局
- (void)updateButtonWithWidth:(CGFloat)width btnSpace:(CGFloat)btnSpace;


@end

@interface UIView (CBViewFrame)

@property (nonatomic, assign) CGFloat cb_Width;

@property (nonatomic, assign) CGFloat cb_Height;

@property (nonatomic, assign) CGFloat cb_CenterX;

@property (nonatomic, assign) CGFloat cb_CenterY;

@end
