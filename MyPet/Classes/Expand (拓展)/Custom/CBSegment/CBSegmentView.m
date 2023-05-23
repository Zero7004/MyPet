//
//  CBSegmentView.m
//  CBSegment
//
//  Created by 陈彬 on 2017/9/9.
//  Copyright © 2017年 com.bingo.com. All rights reserved.
//

#import "CBSegmentView.h"

@interface CBSegmentView ()<UIScrollViewDelegate>
/**
 *  configuration.
 */
{
    CGFloat _HeaderH;
    UIColor *_titleColor;
    UIColor *_titleSelectedColor;
    CBSegmentStyle _SegmentStyle;
    UIFont * _titleFont;
    UIFont * _titleSelectFont;
}
/**
 *  The bottom red slider.
 */
@property (nonatomic, weak) UIView *slider;

@property (nonatomic, strong) NSMutableArray *titleWidthArray;

@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, strong) NSMutableArray *btnArray;

@end

#define CBColorA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define CBScreenH [UIScreen mainScreen].bounds.size.height
#define CBScreenW [UIScreen mainScreen].bounds.size.width
@implementation CBSegmentView

#pragma mark - delayLoading
- (NSMutableArray *)titleWidthArray {
    if (!_titleWidthArray) {
        _titleWidthArray = [NSMutableArray new];
    }
    return _titleWidthArray;
}

#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
//        self.layer.borderColor = CBColorA(204, 204, 204, 1).CGColor;
//        self.layer.borderWidth = 0.5;
        
        _HeaderH = frame.size.height;
        _SegmentStyle = CBSegmentStyleSlider;
        _titleColor = [UIColor darkTextColor];
        _titleSelectedColor = CBColorA(199, 13, 23, 1);
        _titleFont = [UIFont systemFontOfSize:15.0];
        _titleSelectFont = [UIFont systemFontOfSize:15.0];
    }
    return self;
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray {
    [self setTitleArray:titleArray withStyle:0];
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray withStyle:(CBSegmentStyle)style {
    [self setTitleArray:titleArray titleFont:nil titleSelectFont:nil titleColor:nil titleSelectedColor:nil withStyle:style];
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray
            titleFont:(UIFont *)titleFont
            titleSelectFont:(UIFont *)titleSelectFont
           titleColor:(UIColor *)titleColor
   titleSelectedColor:(UIColor *)selectedColor
            withStyle:(CBSegmentStyle)style {
    
//    set style
    if (style != 0) {
        _SegmentStyle = style;
    }
    if (titleFont) {
        _titleFont = titleFont;
    }
    if (titleSelectFont) {
        _titleSelectFont = titleSelectFont;
    }
    if (titleColor) {
        _titleColor = titleColor;
    }
    if (selectedColor) {
        _titleSelectedColor = selectedColor;
    }
    
    if (style == CBSegmentStyleSlider) {
        UIView *slider = [[UIView alloc]init];
        slider.frame = CGRectMake(0, _HeaderH-2, 0, 2);
        slider.backgroundColor = _titleSelectedColor;
        [self addSubview:slider];
        self.slider = slider;
    }
    
    [self.titleWidthArray removeAllObjects];
    [self.btnArray removeAllObjects];
    CGFloat totalWidth = 15;
    CGFloat btnSpace = 15;
    for (NSInteger i = 0; i<titleArray.count; i++) {
//        cache title width
        CGFloat titleWidth = [self widthOfTitle:titleArray[i] titleFont:_titleFont];
        [self.titleWidthArray addObject:[NSNumber numberWithFloat:titleWidth]];
//        creat button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        CGFloat btnW = titleWidth+20;
        btn.frame =  CGRectMake(totalWidth, 0.5, btnW, _HeaderH-0.5-2);
        btn.contentMode = UIViewContentModeCenter;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.tag = i;
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:_titleColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectedColor forState:UIControlStateSelected];
        [btn.titleLabel setFont:_titleFont];
        [btn addTarget:self action:@selector(titleButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        totalWidth = totalWidth+btnW+btnSpace;
        [self.btnArray addObject:btn];
        
        if (i == 0) {
            btn.selected = YES;
            self.selectedBtn = btn;
            if (_SegmentStyle == CBSegmentStyleSlider) {
                self.slider.cb_Width = titleWidth;
                self.slider.cb_CenterX = btn.cb_CenterX;
            }else if (_SegmentStyle == CBSegmentStyleZoom) {
                self.selectedBtn.transform = CGAffineTransformMakeScale(1.3, 1.3);
            } else if (_SegmentStyle == CBSegmentStyleCustom)  {
                [btn.titleLabel setFont:_titleSelectFont];
                CGFloat titleWidth = [self widthOfTitle:titleArray[i] titleFont:_titleSelectFont];
                btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y, titleWidth, btn.frame.size.height);
            }
        }
    }
    totalWidth = totalWidth+btnSpace;
    self.contentSize = CGSizeMake(totalWidth, 0);
}

//  button click
- (void)titleButtonSelected:(UIButton *)btn {
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    if (_SegmentStyle == CBSegmentStyleSlider) {
        NSNumber* sliderWidth = self.titleWidthArray[btn.tag];
        [UIView animateWithDuration:0.2 animations:^{
            self.slider.cb_Width = sliderWidth.floatValue;
            self.slider.cb_CenterX = btn.cb_CenterX;
        }];
    }else if (_SegmentStyle == CBSegmentStyleZoom) {
        [UIView animateWithDuration:0.2 animations:^{
            self.selectedBtn.transform = CGAffineTransformIdentity;
            btn.transform = CGAffineTransformMakeScale(1.3, 1.3);
        }];
    } else if (_SegmentStyle == CBSegmentStyleCustom)  {
        [UIView animateWithDuration:0.2 animations:^{
            self.selectedBtn.titleLabel.font = _titleFont;
            [btn.titleLabel setFont:_titleSelectFont];
            CGFloat titleWidth = [self widthOfTitle:btn.titleLabel.text titleFont:_titleSelectFont];
            btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y, titleWidth, btn.frame.size.height);
        }];
    }
    self.selectedBtn = btn;
    CGFloat offsetX = btn.cb_CenterX - self.frame.size.width*0.5;
    if (offsetX<0) {
        offsetX = 0;
    }
    if (offsetX>self.contentSize.width-self.frame.size.width) {
        offsetX = self.contentSize.width-self.frame.size.width;
    }
    if (self.contentSize.width > self.frame.size.width) {
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    if (self.titleChooseReturn) {
        self.titleChooseReturn(btn.tag);
    }
}

- (void)UpdateTitleButtonSelected:(UIButton *)btn {
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    if (_SegmentStyle == CBSegmentStyleSlider) {
        NSNumber* sliderWidth = self.titleWidthArray[btn.tag];
        [UIView animateWithDuration:0.2 animations:^{
            self.slider.cb_Width = sliderWidth.floatValue;
            self.slider.cb_CenterX = btn.cb_CenterX;
        }];
    }else if (_SegmentStyle == CBSegmentStyleZoom) {
        [UIView animateWithDuration:0.2 animations:^{
            self.selectedBtn.transform = CGAffineTransformIdentity;
            btn.transform = CGAffineTransformMakeScale(1.3, 1.3);
        }];
    } else if (_SegmentStyle == CBSegmentStyleCustom)  {
        [UIView animateWithDuration:0.2 animations:^{
            self.selectedBtn.titleLabel.font = _titleFont;
            [btn.titleLabel setFont:_titleSelectFont];
            CGFloat titleWidth = [self widthOfTitle:btn.titleLabel.text titleFont:_titleSelectFont];
            btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y, titleWidth, btn.frame.size.height);
        }];
    }
    self.selectedBtn = btn;
    CGFloat offsetX = btn.cb_CenterX - self.frame.size.width*0.5;
    if (offsetX<0) {
        offsetX = 0;
    }
    if (offsetX>self.contentSize.width-self.frame.size.width) {
        offsetX = self.contentSize.width-self.frame.size.width;
    }
    if (self.contentSize.width > self.frame.size.width) {
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}

//  cache title width
- (CGFloat)widthOfTitle:(NSString *)title titleFont:(UIFont *)titleFont {
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, _HeaderH-2)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:titleFont}
                                            context:nil].size;
    return titleSize.width;
}

- (void)setSelectIndex:(NSInteger)index {
//    self.selectedBtn.selected = NO;
//    self.selectedBtn = self.btnArray[index];
    [self UpdateTitleButtonSelected:self.btnArray[index]];
}

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray new];
    }
    return _btnArray;
}

- (void)updateSliderUIWith:(CGFloat)width
                    height:(CGFloat)height
                     color:(UIColor *)color
              cornerRadius:(CGFloat)cornerRadius {
    self.slider.backgroundColor = color;
    self.slider.frame = CGRectMake(self.slider.frame.origin.x, self.slider.frame.origin.y - 2, width, height);
    self.slider.layer.masksToBounds = YES;
    self.slider.layer.cornerRadius = cornerRadius;
}

- (void)updateButtonWithWidth:(CGFloat)width btnSpace:(CGFloat)btnSpace {
    CGFloat btnWidth = (width - ((self.btnArray.count - 1) * btnSpace)) / self.btnArray.count;
    __block CGFloat totalWidth = 0;
    [self.btnArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        btn.frame = CGRectMake(totalWidth, 0.5, btnWidth, _HeaderH-0.5-2);
        totalWidth = totalWidth + btnWidth + btnSpace;
        if (idx == 0) {
            if (_SegmentStyle == CBSegmentStyleSlider) {
                self.slider.cb_CenterX = btn.cb_CenterX;
            }
        }
    }];
}

@end

@implementation UIView (CBViewFrame)

- (void)setCb_Width:(CGFloat)cb_Width {
    CGRect frame = self.frame;
    frame.size.width = cb_Width;
    self.frame = frame;
}

- (CGFloat)cb_Width {
    return self.frame.size.width;
}

- (void)setCb_Height:(CGFloat)cb_Height {
    CGRect frame = self.frame;
    frame.size.height = cb_Height;
    self.frame = frame;
}

- (CGFloat)cb_Height {
    return self.frame.size.height;
}

- (void)setCb_CenterX:(CGFloat)cb_CenterX {
    CGPoint center = self.center;
    center.x = cb_CenterX;
    self.center = center;
}

- (CGFloat)cb_CenterX {
    return self.center.x;
}

- (void)setCb_CenterY:(CGFloat)cb_CenterY {
    CGPoint center = self.center;
    center.y = cb_CenterY;
    self.center = center;
}

- (CGFloat)cb_CenterY {
    return self.center.y;
}

@end
