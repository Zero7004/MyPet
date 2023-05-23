//
//  tempViewController.m
//  MyPet
//
//  Created by long on 2021/7/31.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "tempViewController.h"
#import "UIColor+hexColor.h"


@interface tempViewController ()

@end

@implementation tempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = color_white;
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 6;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cc_type"]];
    [topView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(28);
        make.centerX.equalTo(topView.mas_centerX).offset(0);
        make.width.height.offset(40);
    }];
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
     [agreeLabel addGestureRecognizer:tap];
     [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
         @strongify(self)
         self.provisionView = [[ExchangeProvisionsView alloc] init];
         self.provisionView.title = self.InfoModel.purchaseClauseName;
         self.provisionView.ProvisionsContent = self.InfoModel.purchaseClauseText;
         [self.provisionView showAlertView];
     }];


     UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
     [btn setTitle:@"进行中" forState:UIControlStateNormal];
     [btn setTitleColor:[UIColor colorWithHexString:@"#A1A8B3"] forState:UIControlStateNormal];
     [btn setTitleColor:[UIColor colorWithHexString:@"#006AFF"] forState:UIControlStateSelected];
     btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14.0f];
     [btn setSelected:YES];
     btn.layer.cornerRadius = 4;
     btn.layer.masksToBounds = YES;
     btn.backgroundColor = [UIColor colorWithHexString:@"#006AFF" alpha:0.1];
     [buttomView addSubview:btn];
     [btn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(buttomView.mas_centerY).offset(0);
         make.left.equalTo(buttomView).offset(16);
         make.height.offset(28);
         make.width.offset(62);
     }];
     [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
     }];

     UILabel *label = [[UILabel alloc] init];
     label.text = @"·认证后可提现，24小时限额10,000元";
     label.numberOfLines = 0;
     label.textColor = [UIColor colorWithHexString:@"#7A8799"];
     label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13.0f];
     [self.bgView addSubview:label];
     [label mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.bgView).offset(16);
         make.right.equalTo(self.authBtn.mas_left).offset(-16);
         make.bottom.equalTo(self.bgView).offset(20);
         make.top.equalTo(self.levelLabel.mas_bottom).offset(14);
     }];

     label;
     
     UIView *topLine = [UIView new];
     topLine.backgroundColor = color_Line_Color;
     [self.contenView addSubview:topLine];
     [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(subLabel.mas_bottom).offset(40);
         make.left.equalTo(self.bgView).offset(24);
         make.right.equalTo(self.bgView).offset(-24);
         make.height.offset(1);
     }];

     UITextField *inputField = [[UITextField alloc] init];
     inputField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.0f];
     inputField.placeholder = @"请填写转让金额";
     inputField.delegate = self;
     inputField.textColor = [UIColor colorWithHexString:@"#1F2733"];
     inputField.textAlignment = NSTextAlignmentRight;
     [basicView_2 addSubview:inputField];
     [inputField mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(basicView_2.mas_centerY).offset(0);
         make.right.equalTo(amountLa.mas_left).offset(-8);
         make.left.equalTo(amountLabel.mas_right).offset(10);
     }];

     
     */
}


@end
