//
//  CustomPaymentTypeView.m
//  MyPet
//
//  Created by long on 2021/7/25.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "CustomPaymentTypeView.h"
#import "UIColor+hexColor.h"

@interface CustomPaymentTypeView ()
@property (nonatomic, strong) UIImageView *wechatIcon;
@property (nonatomic, strong) UIImageView *alipayIcon;
@property (nonatomic, strong) UIImageView *balanceIcon;
@property (nonatomic, strong) UIImageView *otherIcon;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation CustomPaymentTypeView

- (instancetype)initWith:(CustomPaymentType)type{
    
    self = [super init];
    if (self){
        [self createViewWith:type];
    }
    return self;
}

- (void)createViewWith:(CustomPaymentType)type {
    self.backgroundColor = [UIColor colorWithHexString:@"#F5F7FA"];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"支付方式";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor colorWithHexString:@"#1F2733"];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18.0f];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(16);
    }];

    UIView *bgView = [UIView new];
    bgView.backgroundColor = color_white;
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 6;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(16);
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.height.offset(192);
        make.bottom.equalTo(self).offset(0);
    }];
    self.bgView = bgView;

    UIImageView *WechatImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"repWechat"]];
    [bgView addSubview:WechatImg];
    [WechatImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(18);
        make.left.equalTo(bgView).offset(16);
        make.height.width.offset(28);
    }];
    
    UILabel *wechatLabel = [[UILabel alloc] init];
    wechatLabel.text = @"微信支付";
    wechatLabel.textAlignment = NSTextAlignmentLeft;
    wechatLabel.textColor = [UIColor colorWithHexString:@"#1F2733"];
    wechatLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16.0f];
    [bgView addSubview:wechatLabel];
    [wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(WechatImg.mas_centerY).offset(0);
        make.left.equalTo(WechatImg.mas_right).offset(12);
    }];
    
    self.wechatIcon = ({
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"repNon"]];
        [bgView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(WechatImg.mas_centerY).offset(0);
            make.right.equalTo(bgView).offset(-16);
            make.height.width.offset(20);
        }];
        icon;
    });
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.05];
    [bgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(WechatImg.mas_bottom).offset(18);
        make.left.equalTo(bgView).offset(16);
        make.right.equalTo(bgView).offset(-16);
        make.height.offset(0.5);
    }];
    
    UIImageView *AlipayImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"repAlipay"]];
    [bgView addSubview:AlipayImg];
    [AlipayImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(18);
        make.left.equalTo(bgView).offset(16);
        make.height.width.offset(28);
    }];
    
    UILabel *aliLabel = [[UILabel alloc] init];
    aliLabel.text = @"支付宝支付";
    aliLabel.textAlignment = NSTextAlignmentLeft;
    aliLabel.textColor = [UIColor colorWithHexString:@"#1F2733"];
    aliLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16.0f];
    [bgView addSubview:aliLabel];
    [aliLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(AlipayImg.mas_centerY).offset(0);
        make.left.equalTo(AlipayImg.mas_right).offset(12);
    }];
    
    self.alipayIcon = ({
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"repNon"]];
        [bgView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(AlipayImg.mas_centerY).offset(0);
            make.right.equalTo(bgView).offset(-16);
            make.height.width.offset(20);
        }];
        icon;
    });
    
    //balance
    UIView *lineView2 = [UIView new];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.05];
    [bgView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(AlipayImg.mas_bottom).offset(18);
        make.left.equalTo(bgView).offset(16);
        make.right.equalTo(bgView).offset(-16);
        make.height.offset(0.5);
    }];
    
    UIImageView *balanceImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"repBalance2"]];
    [bgView addSubview:balanceImg];
    [balanceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(18);
        make.left.equalTo(bgView).offset(16);
        make.height.width.offset(28);
    }];
    
    UILabel *balanceLabel = [[UILabel alloc] init];
    balanceLabel.text = @"余额支付";
    balanceLabel.textAlignment = NSTextAlignmentLeft;
    balanceLabel.textColor = [UIColor colorWithHexString:@"#1F2733"];
    balanceLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16.0f];
    [bgView addSubview:balanceLabel];
    [balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(balanceImg.mas_centerY).offset(0);
        make.left.equalTo(balanceImg.mas_right).offset(12);
    }];
    
    self.balanceIcon = ({
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"repNon"]];
        [bgView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(balanceImg.mas_centerY).offset(0);
            make.right.equalTo(bgView).offset(-16);
            make.height.width.offset(20);
        }];
        icon;
    });

    //other
    UIView *lineView3 = [UIView new];
    lineView3.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.05];
    [bgView addSubview:lineView3];
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(balanceImg.mas_bottom).offset(18);
        make.left.equalTo(bgView).offset(16);
        make.right.equalTo(bgView).offset(-16);
        make.height.offset(0.5);
    }];

    UIImageView *otherImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"otherPay"]];
    [bgView addSubview:otherImg];
    [otherImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView3.mas_bottom).offset(18);
        make.left.equalTo(bgView).offset(16);
        make.height.width.offset(28);
    }];
    
    UILabel *otherLabel = [[UILabel alloc] init];
    otherLabel.text = @"代付";
    otherLabel.textAlignment = NSTextAlignmentLeft;
    otherLabel.textColor = [UIColor colorWithHexString:@"#1F2733"];
    otherLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16.0f];
    [bgView addSubview:otherLabel];
    [otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(otherImg.mas_centerY).offset(0);
        make.left.equalTo(otherImg.mas_right).offset(12);
    }];
    
    self.otherIcon = ({
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"repNon"]];
        [bgView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(otherImg.mas_centerY).offset(0);
            make.right.equalTo(bgView).offset(-16);
            make.height.width.offset(20);
        }];
        icon;
    });

    
    //button
    UIButton *wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:wechatBtn];
    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(bgView).offset(0);
        make.height.offset(63);
    }];
    [[wechatBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.wechatIcon.image = [UIImage imageNamed:self.selectIcon ?: @"repSelc"];
        self.alipayIcon.image = [UIImage imageNamed:@"repNon"];
        self.balanceIcon.image = [UIImage imageNamed:@"repNon"];
        self.otherIcon.image = [UIImage imageNamed:@"repNon"];
        if (self.PaymentTypeBlock) {
            self.PaymentTypeBlock(CustomPaymentType_wechat);
        }
    }];

    UIButton *alipayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:alipayBtn];
    [alipayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wechatBtn.mas_bottom).offset(0);
        make.left.right.equalTo(bgView).offset(0);
        make.height.offset(63);
    }];
    [[alipayBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.wechatIcon.image = [UIImage imageNamed:@"repNon"];
        self.alipayIcon.image = [UIImage imageNamed:self.selectIcon ?: @"repSelc"];
        self.balanceIcon.image = [UIImage imageNamed:@"repNon"];
        self.otherIcon.image = [UIImage imageNamed:@"repNon"];
        if (self.PaymentTypeBlock) {
            self.PaymentTypeBlock(CustomPaymentType_alipay);
        }
    }];
    
    UIButton *balanceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:balanceBtn];
    [balanceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alipayBtn.mas_bottom).offset(0);
        make.left.right.equalTo(bgView).offset(0);
        make.height.offset(63);
    }];
    [[balanceBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.wechatIcon.image = [UIImage imageNamed:@"repNon"];
        self.alipayIcon.image = [UIImage imageNamed:@"repNon"];
        self.balanceIcon.image = [UIImage imageNamed:self.selectIcon ?: @"repSelc"];
        self.otherIcon.image = [UIImage imageNamed:@"repNon"];
        if (self.PaymentTypeBlock) {
            self.PaymentTypeBlock(CustomPaymentType_balance);
        }
    }];
    
    UIButton *otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:otherBtn];
    [otherBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(balanceBtn.mas_bottom).offset(0);
        make.left.bottom.right.equalTo(bgView).offset(0);
        make.height.offset(63);
    }];
    [[otherBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.wechatIcon.image = [UIImage imageNamed:@"repNon"];
        self.alipayIcon.image = [UIImage imageNamed:@"repNon"];
        self.balanceIcon.image = [UIImage imageNamed:@"repNon"];
        self.otherIcon.image = [UIImage imageNamed:self.selectIcon ?: @"repSelc"];
        if (self.PaymentTypeBlock) {
            self.PaymentTypeBlock(CustomPaymentType_other);
        }
    }];

    if (type == CustomPaymentType_wechat) {
        self.wechatIcon.image = [UIImage imageNamed:@"repSelc"];
        self.alipayIcon.image = [UIImage imageNamed:@"repNon"];
        self.balanceIcon.image = [UIImage imageNamed:@"repNon"];
        self.otherIcon.image = [UIImage imageNamed:@"repNon"];
    } else if (type == CustomPaymentType_alipay) {
        self.wechatIcon.image = [UIImage imageNamed:@"repNon"];
        self.alipayIcon.image = [UIImage imageNamed:@"repSelc"];
        self.balanceIcon.image = [UIImage imageNamed:@"repNon"];
        self.otherIcon.image = [UIImage imageNamed:@"repNon"];
    } else if (type == CustomPaymentType_balance) {
        self.wechatIcon.image = [UIImage imageNamed:@"repNon"];
        self.alipayIcon.image = [UIImage imageNamed:@"repNon"];
        self.balanceIcon.image = [UIImage imageNamed:@"repSelc"];
        self.otherIcon.image = [UIImage imageNamed:@"repNon"];
    } else {
        self.wechatIcon.image = [UIImage imageNamed:@"repNon"];
        self.alipayIcon.image = [UIImage imageNamed:@"repNon"];
        self.balanceIcon.image = [UIImage imageNamed:@"repNon"];
        self.otherIcon.image = [UIImage imageNamed:@"repSelc"];
    }
}

- (void)updateBgViewColor:(UIColor *)color {
    self.bgView.backgroundColor = color;
}

- (void)setSelectIcon:(NSString *)selectIcon {
    _selectIcon = selectIcon;
    
    self.wechatIcon.image = [UIImage imageNamed:selectIcon];
}

- (void)showOtherPayType {
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(192 + 63);
    }];
}

@end
