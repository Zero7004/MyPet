//
//  MenuView.m
//  MyPet
//
//  Created by 王健龙 on 2019/5/31.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "MenuView.h"
#import "UIColor+hexColor.h"

@interface MenuView ()

/// 选中的按钮
@property (nonatomic, strong) UIButton * selectButton;
/// 选中的view
@property (nonatomic, strong) UIView * lineView;

@end

@implementation MenuView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = color_white;
        self.showsHorizontalScrollIndicator = NO;
//        self.layer.masksToBounds = NO;
//        self.layer.shadowColor = color_228.CGColor;//阴影颜色
//        self.layer.shadowOffset = CGSizeMake(0, 3);//偏移距离
//        self.layer.shadowOpacity = 1;//不透明度
//        self.layer.shadowRadius = 5;//阴影半径
    }
    return self;
}

- (void)menuTitleArray:(NSArray *)titleArray indexBlock:(nonnull void (^)(NSInteger))indexBlock {
    
    self.lineView = [[UIView alloc] init];
    self.lineView.frame = CGRectMake(0, self.height - 6, 20.5, 3);
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#006AFF"];
    self.lineView.layer.cornerRadius = 1.5;
    self.lineView.layer.masksToBounds = YES;
    
    //最多显示三个
    CGFloat titleButtonWith = titleArray.count > 3 ? SCREEN_WIDTH / 4:SCREEN_WIDTH / titleArray.count;
    CGFloat titleButtonX = 0;
    for (int i = 0; i < titleArray.count; i ++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = 211 + i;
        titleButton.frame = CGRectMake(titleButtonX, 0, titleButtonWith, self.height);
        titleButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        [titleButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor colorWithHexString:@"#A1A8B3"] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor colorWithHexString:@"#3D4E66"] forState:UIControlStateSelected];
        [[titleButton rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            [self calculatingOffsetWihtButton:titleButton];
            
            if (indexBlock) {
                indexBlock(i);
            }
            
        }];
        [self addSubview:titleButton];
        if (i == 0) {
            titleButton.selected = YES;
            self.selectButton = titleButton;
            self.lineView.center = CGPointMake(CGRectGetMidX(self.selectButton.frame), self.height - 6);
        }
        if (i == titleArray.count - 1) {
            [self setContentSize:CGSizeMake(CGRectGetMaxX(titleButton.frame), self.height - 6)];
        }
        titleButtonX = titleButtonX + titleButtonWith;
    }
    
    
    [self addSubview:self.lineView];
}

- (void)menuTitle2Array:(NSArray *)titleArray indexBlock:(nonnull void (^)(NSInteger))indexBlock {
    
    self.lineView = [[UIView alloc] init];
    self.lineView.frame = CGRectMake(0, self.height - 6, 20.5, 3);
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#006AFF"];
    self.lineView.layer.cornerRadius = 1.5;
    self.lineView.layer.masksToBounds = YES;

    //最多显示三个
    CGFloat titleButtonWith = SCREEN_WIDTH / titleArray.count;
    CGFloat titleButtonX = 0;
    for (int i = 0; i < titleArray.count; i ++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = 211 + i;
        titleButton.frame = CGRectMake(titleButtonX, 0, titleButtonWith, self.height);
        titleButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        [titleButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor colorWithHexString:@"#A1A8B3"] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor colorWithHexString:@"#3D4E66"] forState:UIControlStateSelected];
        [[titleButton rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            [self calculatingOffsetWihtButton:titleButton];
            
            if (indexBlock) {
                indexBlock(i);
            }
            
        }];
        [self addSubview:titleButton];
        if (i == 0) {
            titleButton.selected = YES;
            self.selectButton = titleButton;
            self.lineView.center = CGPointMake(CGRectGetMidX(self.selectButton.frame), self.height - 6);
        }
        if (i == titleArray.count - 1) {
            [self setContentSize:CGSizeMake(CGRectGetMaxX(titleButton.frame), self.height - 6)];
        }
        titleButtonX = titleButtonX + titleButtonWith;
    }
    
    
    [self addSubview:self.lineView];
}

- (void)menuTitle3Array:(NSArray *)titleArray indexBlock:(nonnull void (^)(NSInteger))indexBlock {
    
    self.lineView = [[UIView alloc] init];
    self.lineView.frame = CGRectMake(0, self.height - 6, 20.5, 3);
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#006AFF"];
    self.lineView.layer.cornerRadius = 1.5;
    self.lineView.layer.masksToBounds = YES;
    
    //最多显示三个
    CGFloat titleButtonWith = 100;
    CGFloat titleButtonX = 0;
    for (int i = 0; i < titleArray.count; i ++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = 211 + i;
        titleButton.frame = CGRectMake(titleButtonX, 0, titleButtonWith, self.height);
        titleButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        [titleButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor colorWithHexString:@"#A1A8B3"] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor colorWithHexString:@"#3D4E66"] forState:UIControlStateSelected];
        [[titleButton rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            [self calculatingOffsetWihtButton:titleButton];
            
            if (indexBlock) {
                indexBlock(i);
            }
            
        }];
        [self addSubview:titleButton];
        if (i == 0) {
            titleButton.selected = YES;
            self.selectButton = titleButton;
            self.lineView.center = CGPointMake(CGRectGetMidX(self.selectButton.frame), self.height - 6);
        }
        if (i == titleArray.count - 1) {
            [self setContentSize:CGSizeMake(CGRectGetMaxX(titleButton.frame), self.height - 6)];
        }
        titleButtonX = titleButtonX + titleButtonWith;
    }

    
    [self addSubview:self.lineView];
}

/**
 计算偏移量

 @param titleButton 按钮
 */
- (void)calculatingOffsetWihtButton:(UIButton *)titleButton {
    
    //取消之前选中的按钮
    self.selectButton.selected = NO;
    titleButton.selected = YES;
    self.selectButton = titleButton;
    
    //计算偏移量
//    [UIView animateWithDuration:0.1 animations:^{
//        self.lineView.center = CGPointMake(CGRectGetMidX(self.selectButton.frame) - 15, self.lineView.centerY);
//    }];
//    [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionLayoutSubviews animations:^{
//        self.lineView.center = CGPointMake(CGRectGetMidX(self.selectButton.frame) + 30, self.lineView.centerY);
//    } completion:nil];
    [UIView animateWithDuration:0.0 delay:0.1 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.lineView.center = CGPointMake(CGRectGetMidX(self.selectButton.frame), self.lineView.centerY);
    } completion:nil];
    
    //点击动画 前四后四初始位置 其它位置居中
    if (CGRectGetMaxX(titleButton.frame) >= self.frame.size.width) {
        
        [UIView animateWithDuration:0.1 animations:^{
            self.contentOffset = CGPointMake(CGRectGetMinX(titleButton.frame) - 15, 0);
            //解决一下刚好卡住的问题
            if (self.contentSize.width - self.contentOffset.x <= self.width) {
                self.contentOffset = CGPointMake(self.contentSize.width - self.width, 0);
            } else {
                self.contentOffset = CGPointMake(titleButton.x - self.width / 2 + titleButton.width / 2, 0);
            }
        }];
        
    }  else {
        self.contentOffset = CGPointMake(0, 0);
    }
}


/**
 设置选中按钮

 @param selectedSegmentIndex 索引
 */
- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
    _selectedSegmentIndex = selectedSegmentIndex;
    UIButton *titleButton = (UIButton *)[self viewWithTag:211 + selectedSegmentIndex];
    if (![titleButton isEqual:self.selectButton]) {
        [self calculatingOffsetWihtButton:titleButton];
    }
}

@end
