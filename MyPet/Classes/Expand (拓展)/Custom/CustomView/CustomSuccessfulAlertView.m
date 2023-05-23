//
//  CustomSuccessfulAlertView.m
//  MyPet
//
//  Created by long on 2021/7/31.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "CustomSuccessfulAlertView.h"
#import "UIColor+hexColor.h"
#import "CustomButtonView.h"

#define AlertViewHeight (405 + Bottom_SafeHeight)

@interface CustomSuccessfulAlertView ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contenView;
@property (nonatomic, strong) CustomButtonView *confirmBtn;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation CustomSuccessfulAlertView

- (instancetype)init{
    
    self = [super init];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.bgView = ({
        UIView *bgView = [UIView new];
        bgView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.5];
        [window addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(window).offset(0);
        }];
        
        bgView;
    });
    
    self.contenView = ({
        UIView *contenView = [UIView new];
        contenView.backgroundColor = color_white;
        contenView.layer.cornerRadius = 10;
        contenView.layer.masksToBounds = YES;
        [self.bgView addSubview:contenView];
        contenView.frame = CGRectMake(0, Screen_Height, Screen_Width, AlertViewHeight);
        
        contenView;
    });
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"exch_close"] forState:UIControlStateNormal];
    [self.contenView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contenView).offset(-16);
        make.top.equalTo(self.contenView).offset(15);
        make.height.offset(30);
        make.width.offset(30);
    }];
    @weakify(self)
    [[closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (self.CloseBlock) {
            self.CloseBlock();
        }
        [self hiddenAlertView];
    }];
    
    UIImageView *topIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cc_succ"]];
    [self.contenView addSubview:topIcon];
    [topIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(56);
        make.top.equalTo(self.contenView).offset(55.5);
        make.centerX.equalTo(self.contenView.mas_centerX).offset(0);
    }];
    
    UILabel *succLabel = [[UILabel alloc] init];
    succLabel.text = @"交易成功";
    succLabel.textColor = [UIColor colorWithHexString:@"#1F2733"];
    succLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:22.0f];
    [self.contenView addSubview:succLabel];
    [succLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topIcon.mas_bottom).offset(24);
        make.centerX.equalTo(self.contenView.mas_centerX).offset(0);
    }];
    
    UILabel *subLabel = [[UILabel alloc] init];
    subLabel.text = @"可在订单页面查看";
    subLabel.textColor = [UIColor colorWithHexString:@"#7A8799"];
    subLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16.0f];
    subLabel.numberOfLines = 3;
    subLabel.textAlignment = NSTextAlignmentCenter;
    [self.contenView addSubview:subLabel];
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(succLabel.mas_bottom).offset(16);
        make.centerX.equalTo(self.contenView.mas_centerX).offset(0);
        make.left.equalTo(self.contenView).offset(16);
        make.right.equalTo(self.contenView).offset(-16);
    }];
    self.tipLabel = subLabel;
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = color_Line_Color;
    [self.contenView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subLabel.mas_bottom).offset(40);
        make.left.equalTo(self.bgView).offset(24);
        make.right.equalTo(self.bgView).offset(-24);
        make.height.offset(1);
    }];

    UILabel *timeLa = [[UILabel alloc] init];
    timeLa.text = @"交易时间";
    timeLa.textColor = [UIColor colorWithHexString:@"#999999"];
    timeLa.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.0f];
    [self.contenView addSubview:timeLa];
    [timeLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLine.mas_bottom).offset(20);
        make.left.equalTo(self.bgView).offset(24);
    }];

    self.timeLabel = ({
        UILabel *label = [[UILabel alloc] init];
        NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
        [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [NSDate date];
        label.text = [dataFormatter stringFromDate:date];
        label.textColor = [UIColor colorWithHexString:@"#1F2733"];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.0f];
        label.textAlignment = NSTextAlignmentRight;
        [self.contenView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topLine.mas_bottom).offset(20);
            make.right.equalTo(self.bgView).offset(-24);
        }];
        label;
    });
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = color_Line_Color;
    [self.contenView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(20);
        make.left.equalTo(self.bgView).offset(24);
        make.right.equalTo(self.bgView).offset(-24);
        make.height.offset(1);
    }];
    
    //底部按钮
    self.confirmBtn = ({
        CustomButtonView *btn = [[CustomButtonView alloc] initViewWithButtonType:CustomButtonView_def String:@"查看期权账户"];
        [self.contenView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(48);
            make.left.equalTo(self.contenView).offset(24);
            make.right.equalTo(self.contenView).offset(-24);
            make.bottom.equalTo(self.contenView).offset(-Bottom_SafeHeight);
        }];
        @weakify(self)
        btn.ButtonClickBlock = ^{
            @strongify(self)
            if (self.ActionBlock) {
                self.ActionBlock();
                [self hiddenAlertView];
            }
        };
        btn;
    });

}

// MARK: - function
- (void)showAlertView {
    [UIView animateWithDuration:0.25 animations:^{
        self.contenView.frame = CGRectMake(0, Screen_Height - AlertViewHeight, Screen_Width, AlertViewHeight);
    }];
}

- (void)hiddenAlertView {
    [UIView animateWithDuration:0.25 animations:^{
        self.contenView.frame = CGRectMake(0, Screen_Height, Screen_Width, AlertViewHeight);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeAllView];
        }
    }];
}

- (void)removeAllView {
    for (UIView *view in self.bgView.subviews) {
        [view removeFromSuperview];
    }
    [self.bgView removeFromSuperview];
    self.bgView = nil;
}


- (void)setTipString:(NSString *)tipString {
    self.tipLabel.text = tipString;
}

- (void)setBtnString:(NSString *)btnString {
    [self.confirmBtn setButtonTtile:btnString];
}


@end
