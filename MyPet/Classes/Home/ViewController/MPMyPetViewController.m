//
//  MPMyPetViewController.m
//  MyPet
//
//  Created by long on 2023/5/24.
//  Copyright © 2023 王健龙. All rights reserved.
//

#import "MPMyPetViewController.h"
#import "CycleImageView.h"
#import "MPEggCollectionView.h"
#import "UIButton+LXMImagePosition.h"

@interface MPMyPetViewController ()

@property (nonatomic, strong) UIImageView *topBG;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) MPEggCollectionView *petCollectionView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *petNameLabel;
@property (nonatomic, strong) UILabel *petNumLabel;
@property (nonatomic, strong) UILabel *hatchTimeLabel;
@property (nonatomic, strong) UIButton *hatchTimeBtn;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation MPMyPetViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initView];
}

- (void)initView {
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.topBG = ({
        UIImageView *topBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgLV4"]];
        [self.view addSubview:topBG];
        [topBG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view).offset(0);
        }];

        topBG;
    });
    
    self.petCollectionView = ({
        MPEggCollectionView *view = [[MPEggCollectionView alloc] initWithItemSize:CGSizeMake(180, 119)];
//        view.backgroundColor = UIColor.redColor;
        [self.topBG addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(0);
            make.width.offset(180);
            make.height.offset(119);
            make.top.equalTo(self.view).offset([self getStatusHeight] + 19 + 24);
        }];
        
        view;
    });
    
    self.leftBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"icon_left"] forState:UIControlStateNormal];
        [self.topBG addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.petCollectionView.mas_centerY).offset(0);
            make.left.offset(12);
            make.width.height.offset(34);
        }];
        @weakify(self)
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
        }];

        
        btn;
    });
    
    self.rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"icon_right"] forState:UIControlStateNormal];
        [self.topBG addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.petCollectionView.mas_centerY).offset(0);
            make.right.offset(-12);
            make.width.height.offset(34);
        }];
        @weakify(self)
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
        }];

        
        btn;
    });
    
    UIView *petNameBG = [UIView new];
    petNameBG.backgroundColor = UIColor.whiteColor;
    petNameBG.layer.cornerRadius = 11;
    petNameBG.layer.masksToBounds = YES;
    petNameBG.alpha = 0.7;
    [self.topBG addSubview:petNameBG];
    [petNameBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.petCollectionView.mas_bottom).offset(4);
        make.centerX.equalTo(self.topBG.mas_centerX).offset(0);
        make.width.offset(140);
        make.height.offset(22);
    }];
    self.petNameLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"Random Egg…";
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"#373737"];
        label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:12.0f];
        [petNameBG addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(petNameBG.mas_centerX).offset(0);
            make.width.offset(140);
            make.height.offset(22);
        }];

        label;
    });
    
    self.petNumLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"1/12";
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"#373737"];
        label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:14.0f];
        [self.topBG addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(petNameBG.mas_bottom).offset(4);
            make.centerX.equalTo(self.topBG.mas_centerX).offset(0);
            make.width.offset(140);
            make.height.offset(22);
        }];

        label;
    });

    UIView *hatchView = [self getHatchTimeView];
    [self.topBG addSubview:hatchView];
    [hatchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.petNumLabel.mas_bottom).offset(14);
        make.centerX.equalTo(self.topBG.mas_centerX).offset(0);
        make.bottom.equalTo(self.topBG.mas_bottom).offset(-16-19);
    }];

    
    self.bottomView = ({
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = UIColor.whiteColor;
        bottomView.layer.cornerRadius = 16;
        bottomView.layer.masksToBounds = YES;
        [self.view addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view).offset(0);
            make.top.equalTo(self.topBG.mas_bottom).offset(-19);
        }];
        
        bottomView;
    });
    
    self.saveBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"Save to Widget" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#003150"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:20.0f];
        btn.layer.cornerRadius = 25;
        btn.layer.shadowColor = [UIColor colorWithHexString:@"#091E46" alpha:0.14].CGColor;
        btn.layer.shadowOffset = CGSizeMake(0,5);
        btn.layer.shadowOpacity = 1;
        btn.layer.shadowRadius = 5;
        btn.backgroundColor = [UIColor colorWithHexString:@"#FFF87B" alpha:1.0];
        [btn setImagePosition:LXMImagePositionLeft spacing:6];
        [self.bottomView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bottomView.mas_centerX).offset(0);
            make.top.equalTo(self.bottomView).offset(51);
            make.height.offset(49);
            make.width.offset(212);
        }];
        @weakify(self)
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
        }];
        
        btn;
    });
    
    self.tipsLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"Saving this egg to your lock screen widget now can reduce the hatching time by 6 hours";
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"#373737"];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0f];
        [self.bottomView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bottomView.mas_centerX).offset(0);
            make.top.equalTo(self.saveBtn.mas_bottom).offset(17);
            make.left.equalTo(@20);
            make.right.equalTo(@-20);
        }];

        label;
    });
}

- (UIView *)getHatchTimeView {
    UIView *bgView = [UIView new];
    bgView.backgroundColor = UIColor.whiteColor;
    bgView.layer.cornerRadius = 12;
    bgView.layer.masksToBounds = YES;
    bgView.alpha = 0.7;
    
    self.hatchTimeLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"Remaining hatching time";
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"#003150"];
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12.0f];
        [bgView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).offset(7);
            make.left.equalTo(bgView).offset(22);
            make.right.equalTo(bgView).offset(-22);
        }];

        label;
    });
    
    self.hatchTimeBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"23:00:12" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"eggIcon"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#003150"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:22.0f];
        [btn setImagePosition:LXMImagePositionLeft spacing:7];
        [bgView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.hatchTimeLabel.mas_bottom).offset(5);
            make.height.offset(26);
            make.left.equalTo(bgView).offset(22);
            make.right.equalTo(bgView).offset(-22);
            make.bottom.equalTo(bgView).offset(-8);
        }];

        btn;
    });

    return bgView;
}

- (CGFloat)getStatusHeight {
    CGFloat height = 0.0;//最终高度存储容器
    if (@available(iOS 13.0, *)) {
        CGFloat topHeight = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.top;
        height = topHeight ? topHeight : 20.0;
    }else {
        height = [[UIApplication sharedApplication] statusBarFrame].size.height;
    }
    return height + TabBarHeight;
}


@end
