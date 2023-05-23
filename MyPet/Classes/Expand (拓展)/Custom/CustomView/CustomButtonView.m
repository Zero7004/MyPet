//
//  CustomButtonView.m
//  MyPet
//
//  Created by long on 2021/7/24.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "CustomButtonView.h"
#import "UIColor+hexColor.h"

@interface CustomButtonView ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger timeIndex;

@end

@implementation CustomButtonView

- (instancetype)initViewWithButtonType:(CustomButtonViewType)buttonType
                                String:(NSString *)string {
    
    self = [super init];
    if (self){
        self.title = string;
        [self createWithButtonType:buttonType String:string];
    }
    return self;
}

- (instancetype)initViewWithButtonType:(CustomButtonViewType)buttonType
                                String:(NSString *)string
                             TimeIndex:(NSInteger)timeIndex {
    
    self = [super init];
    if (self){
        self.timeIndex = timeIndex;
        self.title = string;
        [self createWithButtonType:buttonType String:string];
        [self startCountDownWith:timeIndex];
        
    }
    return self;
}

- (void)createWithButtonType:(CustomButtonViewType)buttonType String:(NSString *)string {
    if (buttonType == CustomButtonView_gray) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F5F7FA"];
    } else if (buttonType == CustomButtonView_while) {
        self.backgroundColor = color_white;
    } else if (buttonType == CustomButtonView_coudown) {
        self.backgroundColor = [UIColor colorWithHexString:@"#006AFF"];
    } else {
        self.backgroundColor = [UIColor colorWithHexString:@"#006AFF"];
    }
    
    self.button = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16.0f];
        if (buttonType == CustomButtonView_gray) {
            [button setTitleColor:[UIColor colorWithHexString:@"#006AFF"] forState:UIControlStateNormal];
            [button setTitle:string forState:UIControlStateNormal];
        } else if (buttonType == CustomButtonView_while) {
            [button setTitleColor:[UIColor colorWithHexString:@"#006AFF"] forState:UIControlStateNormal];
            [button setTitle:string forState:UIControlStateNormal];
        } else if (buttonType == CustomButtonView_coudown) {
            [button setTitleColor:color_white forState:UIControlStateNormal];
            [button setTitle:[NSString stringWithFormat:@"%@(%lds)", string, (long)self.timeIndex] forState:UIControlStateNormal];
        } else {
            [button setTitleColor:color_white forState:UIControlStateNormal];
            [button setTitle:string forState:UIControlStateNormal];
        }
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self).offset(0);
        }];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.ButtonClickBlock) {
                self.ButtonClickBlock();
            }
        }];
        
        button;
    });
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8;

}

- (void)setButtonTtileFont:(UIFont *)font {
    self.button.titleLabel.font = font;
}

- (void)setButtonTtile:(NSString *)title {
    [self.button setTitle:title forState:UIControlStateNormal];
}

- (void)startCountDownWith:(NSInteger)timeIndex {
    [self.button setEnabled:NO];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction {
    self.timeIndex--;
    [self.button setTitle:[NSString stringWithFormat:@"%@(%lds)", self.title, (long)self.timeIndex] forState:UIControlStateNormal];
    if (self.timeIndex <= 0) {
        [self.button setEnabled:YES];
        [self.button setTitle:self.title forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}


@end
