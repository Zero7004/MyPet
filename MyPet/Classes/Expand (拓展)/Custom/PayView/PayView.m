//
//  PayView.m
//  MyPet
//
//  Created by 王健龙 on 2020/4/19.
//  Copyright © 2020 王健龙. All rights reserved.
//

#import "PayView.h"
#import "PayTableViewCell.h"
#import "PayManager.h"

@interface PayView () <UITableViewDelegate,UITableViewDataSource,PayDelegate>
/// 高度
@property (assign ,nonatomic) CGFloat payHeight;
/// 支付背景视图
@property (strong ,nonatomic) UIView *payBackGroundView;
/// 支付菜单
@property (strong ,nonatomic) NSMutableArray *payMutArray;
/// 支付表格
@property (strong ,nonatomic) UITableView *payTableView;
/// 金额
@property (strong ,nonatomic) UILabel *amountLabel;
@end

@implementation PayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        //设置蒙版
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.payBackGroundView.top = self.payBackGroundView.top - self.payHeight;
    }];
}

- (void)setPayMent:(PayMent)payMent {
    _payMent = payMent;
}

- (void)setPayModel:(PayModel *)payModel {
    _payModel = payModel;
    if (!self.payHeight) {
        self.payHeight = 368;
    }
    [self initData];
    [self initUI];
}

- (void)setPayType:(PayType)payType {
    _payType = payType;
}

- (void)setIsHideBalancePay:(BOOL)isHideBalancePay {
    _isHideBalancePay = isHideBalancePay;
    if (isHideBalancePay) {
        self.payHeight = 318;
    } else {
        self.payHeight = 368;
    }
}

#pragma mark - 初始化数据
- (void)initData {
    self.payMutArray = [NSMutableArray arrayWithArray:@[@{@"icon":@"pay_wexin_icon",@"name":@"微信支付"},@{@"icon":@"pay_alipay_icon",@"name":@"支付宝支付"},@{@"icon":@"pay_balance_icon",@"name":@"余额支付"}]];
    if (self.isHideBalancePay) {
        [self.payMutArray removeLastObject];
    }
}

#pragma mark - 初始化视图
- (void)initUI {
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = UIColor.clearColor;
    backgroundView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self addSubview:backgroundView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        [self hide];
    }];
    [backgroundView addGestureRecognizer:tap];
    
    [Tools viewRadiusWithView:self.payBackGroundView byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    [self addSubview:self.payBackGroundView];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 24, SCREEN_WIDTH, 25);
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18.0];
    titleLabel.text = @"确认支付";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = RGB(26, 26, 26);
    [self.payBackGroundView addSubview:titleLabel];
    
    self.amountLabel.text = [NSString stringWithFormat:@"¥ %@",self.payModel.amount];
    [self.payBackGroundView addSubview:self.amountLabel];
    
    self.payTableView.frame = CGRectMake(0, self.amountLabel.bottom + 20, SCREEN_WIDTH, self.payMutArray.count * 50);
    [self.payBackGroundView addSubview:self.payTableView];
    
    // 确定按钮
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake(40, self.payTableView.bottom + 20, SCREEN_WIDTH - 40 *2, 43);
    confirmButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16.0];
    [confirmButton setTitle:@"确认支付" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton gradientButtonWithSize:CGSizeMake(SCREEN_WIDTH - 37*2, 43) colorArray:@[(id)RGBA(255, 125, 69, 1),(id)RGBA(255, 60, 48, 1)] percentageArray:@[@(0.0),@(1.0)] gradientType:GradientFromLeftToRight];
    [[confirmButton rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self getPay];
    }];
    ViewRadius(confirmButton, confirmButton.height / 2);
    [self.payBackGroundView addSubview:confirmButton];
    
    if (self.payType == PayTypeAssessCount || self.payType == PayTypeSearch) {
        // 确定按钮
        UIButton *openViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        openViewButton.frame = CGRectMake(0, confirmButton.bottom + 8, SCREEN_WIDTH, 20);
        openViewButton.titleLabel.font = [UIFont systemFontOfSize:12];
        if (self.payType == PayTypeAssessCount) {
            [openViewButton setTitle:@"充值会员可以免费评估，前往充值?" forState:UIControlStateNormal];
        } else {
            [openViewButton setTitle:@"充值会员可以免费查册，前往充值?" forState:UIControlStateNormal];
        }
        [openViewButton setTitleColor:color_153 forState:UIControlStateNormal];
        [[openViewButton rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.opneVipReply) {
                self.opneVipReply();
            }
        }];
        [self.payBackGroundView addSubview:openViewButton];
    }
}

#pragma mark - UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.payMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayTableViewCell"];
    if (!cell) {
        cell = [[PayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PayTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.iconImageView.image = [UIImage imageNamed:self.payMutArray[indexPath.row][@"icon"]];
    cell.titleLabel.text = self.payMutArray[indexPath.row][@"name"];
    if (self.payMent == indexPath.row) {
        cell.isSelect = YES;
    } else {
        cell.isSelect = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            // 微信支付
            self.payMent = PayMentWexin;
            break;
        case 1:
            // 支付宝支付
            self.payMent = PayMentAliPay;
            break;
        case 2:
            // 余额支付
            self.payMent = PayMentBalance;
            break;
        default:
            break;
    }
    [tableView reloadData];
}

#pragma mark - 移除
- (void)hide {
    [UIView animateWithDuration:0.4 animations:^{
        self.payBackGroundView.bottom = self.payBackGroundView.bottom + self.payHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 支付
- (void)getPay {
    NSInteger payMent = self.payMent + 1;
    if (payMent == 3) {
        payMent = 0;
    }
    [SVProgressHUD show];
    NSString *path;
    NSDictionary *parameters;
    switch (self.payType) {
        case 0:
            path = @"/assess/assessmentPayment";
            parameters = @{@"type":@(payMent)};
            break;
        case 1:
            path = @"/assessmentReportOrder/assessmentReportOrderAdd";
            parameters = @{@"payType":@(payMent),@"id":self.payModel.prepayId};
            break;
        case 2:
            path = @"/moneyRechargeRule/recharge";
            parameters = @{@"payType":@(payMent),@"money":self.payModel.amount};
            break;
        case 3:
            path = @"/vip/openVip";
            parameters = @{@"type":@(payMent),@"vipLevel":self.payModel.vipLevel,@"vipTimes":self.payModel.vipTimes};
            break;
        case 4:
            path = @"/searchBooklet/searchPayment";
            parameters = @{@"type":@(payMent)};
            break;
        case 5:
            path = @"/creditInquiry/creditInvestigationPayment";
            parameters = @{@"type":@(payMent)};
            break;
        default:
            break;
    }
    [[KLNetworking shareManager] sendRequestMethod:HTTPMethodPOST path:path parameters:parameters success:^(BOOL isSuccess, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == RequestSuccess) {
            [self goPay:responseObject];
        } else {
            [Tools handleServerStatusCodeDictionary:responseObject];
            if ([responseObject[@"code"] integerValue] == 518) {
                [self hide];
//                [self goRecharge];
            }
        }
    } failure:^(id  _Nonnull error) {
        
    }];
}

- (void)goPay:(NSDictionary *)responseObject {
    PayModel *model = [PayModel mj_objectWithKeyValues:responseObject[@"data"]];
    switch (self.payMent) {
        case 0:
            // 微信支付
            [[PayManager sharedManager] wechatPlayPartnerId:model.partnerId Appid:model.appId PrepayId:model.prepayId NonceStr:model.nonceStr timeStamp:model.timeStamp Package:model.package Sign:model.paySign delegate:self];
            break;
        case 1:
            [PayManager sharedManager].delegate = self;
            // 支付宝支付
            [[AlipaySDK defaultService] payOrder:responseObject[@"data"][@"data"] fromScheme:@"com.gzkjaj.Loans-Users" callback:^(NSDictionary *resultDic) {
                
            }];
            break;
        case 2:
            // 余额支付
            if ([responseObject[@"code"] intValue] == 1) {
                [self managerDidRecvPayResult:PaySuccess];
            }
            break;
        default:
            break;
    }
}


// 代理
- (void)managerDidRecvPayResult:(PayResult)response {
    switch (response) {
        case PaySuccess:
            [SVProgressHUD showSuccessWithStatus:@"支付成功"];
            [self hide];
            if (self.payBlock) {
                self.payBlock(YES);
            }
            break;
        case PayUserCancel:
            // 不操作
            break;
        case PayUnsupported:
            [SVProgressHUD showSuccessWithStatus:@"未安装客户端"];
            [self hide];
            break;
        case PayProcessing:
            [SVProgressHUD showSuccessWithStatus:@"请查询订单列表中订单的支付状态"];
            [self hide];
           break;
        case PayFailure:
            [SVProgressHUD showSuccessWithStatus:@"支付失败"];
            if (self.payBlock) {
                self.payBlock(NO);
            }
            break;
        default:
            break;
    }
}


#pragma mark - 懒加载
- (UIView *)payBackGroundView {
    if (!_payBackGroundView) {
        _payBackGroundView = [[UIView alloc] init];
        _payBackGroundView.backgroundColor = [UIColor whiteColor];
        _payBackGroundView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.payHeight);
        _payBackGroundView.layer.cornerRadius = 10;
    }
    return _payBackGroundView;
}

- (UILabel *)amountLabel {
    if (!_amountLabel) {
        _amountLabel = [[UILabel alloc] init];
        _amountLabel.frame = CGRectMake(0, 59, SCREEN_WIDTH, 40);
        _amountLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:28.0];
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        _amountLabel.textColor = RGBA(224, 32, 32, 1);
        _amountLabel.text = [NSString stringWithFormat:@"¥ %@",self.payModel.amount];
    }
    return _amountLabel;
}

- (UITableView *)payTableView {
    if (!_payTableView) {
        _payTableView = [[UITableView alloc] init];
        _payTableView.bounces = NO;
        _payTableView.delegate = self;
        _payTableView.dataSource = self;
        _payTableView.showsVerticalScrollIndicator = NO;
        _payTableView.rowHeight = 50;
        _payTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_payTableView registerClass:NSClassFromString(@"PayTableViewCell") forCellReuseIdentifier:@"PayTableViewCell"];
    }
    return _payTableView;
}

@end
