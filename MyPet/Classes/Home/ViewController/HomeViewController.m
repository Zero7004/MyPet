//
//  HomeViewController.m
//  MyPet
//
//  Created by long on 2022/7/19.
//  Copyright © 2022 王健龙. All rights reserved.
//

#import "HomeViewController.h"
#import "UIColor+hexColor.h"
#import "SearchView.h"
#import "CycleImageView.h"
#import "SearchViewController.h"
#import "FunctionCustomView.h"
#import "FunctionListView.h"
#import "SelectLabelVC.h"

@interface HomeViewController ()<CycleImageViewDelegate>

@property (nonatomic, strong) UIView *navBGView;
@property (nonatomic, strong) SearchView *searchView;
@property (nonatomic, strong) CycleImageView *cycleImageView;
@property (nonatomic, strong) UIView *newsRedPoint;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
/// 滚动图
@property (nonatomic, strong) NSMutableArray * adArray;
//通知view
@property (nonatomic, strong) UIView *noticeView;
@property (nonatomic, strong) UIView *noticeLabel;
//常用功能
@property (nonatomic, strong) FunctionCustomView *commonView;
//功能列表
@property (nonatomic, strong) FunctionListView *funcListView;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self getStatusNotRead];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNav];
    [self loadData];
}

// MARK: - request
- (void)loadData {
    
    [self setUpUI];
}

- (NSArray *)createCommonData {
    NSMutableArray *modelArray = [NSMutableArray new];
    NSArray *titleArray = @[@"查评估", @"客户预审", @"诉讼查询", @"会员邀请"];
    for (int i = 0; i < titleArray.count; i++) {
        FunctionItmeDM *model = [FunctionItmeDM new];
        model.title = titleArray[i];
        model.iconName = [NSString stringWithFormat:@"home_com_0%d", i + 1];
        [modelArray addObject:model];
    }
    
    return [modelArray copy];
}

- (void)getStatusNotRead {
//    @weakify(self)
//    [[KLNetworking shareManager] sendRequestMethod:HTTPMethodGET path:@"/inform/getStatusNotRead" parameters:@{} success:^(BOOL isSuccess, id  _Nullable responseObject) {
//        @strongify(self)
//        if ([responseObject[@"code"] integerValue] == NewRequestSuccess) {
//            NSString *totalNotRead = responseObject[@"data"][@"totalNotRead"];
//            if ([totalNotRead integerValue] > 0) {
//                self.newsRedPoint.hidden = NO;
//            } else {
//                self.newsRedPoint.hidden = YES;
//            }
//        } else {
//            self.newsRedPoint.hidden = YES;
//        }
//    } failure:^(id  _Nonnull error) {
//    }];
}


// MARK: - function
//设置导航栏
- (void)setUpNav {
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F7FA"];
    
    CGFloat topViewH = 288;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_home_bg"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.right.equalTo(self.view).offset(0);
        make.height.offset(topViewH + StatusBar_Height - 20);
    }];
    
    UIView *navBGView = [[UIView alloc] initWithFrame:CGRectMake(0, StatusBar_Height, Screen_Width, 64)];
    [self.view addSubview:navBGView];
    navBGView.backgroundColor = [UIColor clearColor];
    self.navBGView = navBGView;
    
    //两侧按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [navBGView addSubview:leftBtn];
    [leftBtn setImage:[UIImage imageNamed:@"new_home_topIcon"] forState:UIControlStateNormal];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(navBGView.mas_centerY).offset(0);
        make.left.mas_equalTo(16);
        make.width.offset(104.5);
        make.height.offset(24);
    }];
    @weakify(self)
    [[leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)

        SelectLabelVC *vc = [[SelectLabelVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"new_home_news"] forState:UIControlStateNormal];
    [navBGView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(navBGView.mas_centerY).offset(0);
        make.right.equalTo(navBGView).offset(-16);
        make.height.offset(20);
        make.width.offset(20);
    }];
    [[rightBtn rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        @strongify(self)
//        if ([UserManager isLogin]) {
//            NewsViewController *vc = [NewsViewController new];
//            [self.navigationController pushViewController:vc animated:YES];
//        } else {
//            LogViewController *vc = [LogViewController new];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
    }];
    [rightBtn addSubview:self.newsRedPoint];
    [self.newsRedPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
        make.width.height.offset(4);
    }];

    //搜索框
     self.searchView = [[SearchView alloc] initWithFrame:CGRectMake(16 + 104.5 + 14.4, 15, SCREEN_WIDTH - 32 - 104.5 - 14.2 - 20 - 18, 34) placeholder:@"" clikc:^{
        SearchViewController *searchVC = [[SearchViewController alloc] init];
        [self.navigationController pushViewController:searchVC animated:YES];
    }];
    [navBGView addSubview:self.searchView];

}

- (void)setUpUI {
    self.scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navBGView.mas_bottom).offset(0);
            make.left.right.equalTo(@0);
            make.width.offset(SCREEN_WIDTH);
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-BottomSafeAreaHeight);
        }];
        
        scrollView;
    });

    self.contentView = ({
        UIView *contentView = [UIView new];
        contentView.backgroundColor = [UIColor clearColor];
        [self.scrollView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.scrollView).offset(0);
            make.width.offset(SCREEN_WIDTH);
            make.height.greaterThanOrEqualTo(self.scrollView);
        }];
        contentView;
    });

    if (self.adArray.count == 0) {
        self.cycleImageView = ({
            CycleImageView *cycleImageView = [[CycleImageView alloc] init];
            cycleImageView.timeInterval = 3;
            cycleImageView.delegate = self;
            cycleImageView.backgroundColor = UIColor.blueColor;
            [self.contentView addSubview:cycleImageView];
            [cycleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(14.5);
                make.left.equalTo(self.contentView).offset(16);
                make.right.equalTo(self.contentView).offset(-16);
                make.height.offset((SCREEN_WIDTH - 32) * 114 / 375);
            }];
            
            cycleImageView;
        });
    }
    
    [self.contentView addSubview:self.noticeView];
    [self.noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.adArray.count == 0) {
            make.top.equalTo(self.cycleImageView.mas_bottom).offset(16);
        } else {
            make.top.equalTo(self.contentView).offset(16);
        }
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.height.offset(30);
    }];
    
    self.commonView = ({
        NSArray *dataArray = [self createCommonData];
        CGSize itmeSize = CGSizeMake((SCREEN_WIDTH - 68) / 4, 107);
        FunctionCustomView *commonView = [[FunctionCustomView alloc] initWithItemSize:itmeSize title:@"常用应用"];
        [commonView setDataArray:dataArray itemCount:4];
//        weakify(self)
        commonView.SelectBlock = ^(FunctionItmeDM * _Nonnull model) {
//            @strongify(self)
        };
        [self.contentView addSubview:commonView];
        [commonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.noticeView.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(-16);
        }];
        
        commonView;
    });
    
    self.funcListView = ({
        FunctionListView *view = [[FunctionListView alloc] init];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commonView.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(-16);
//            make.height.offset(400);
            make.bottom.equalTo(self.contentView).offset(0);
        }];

        view;
    });
}

// MARK: - init
- (NSMutableArray *)adArray {
    if (!_adArray) {
        _adArray = [NSMutableArray array];
    }
    return _adArray;
}

- (UIView *)noticeView {
    if (!_noticeView) {
        _noticeView = [UIView new];
        _noticeView.backgroundColor = color_white;
        _noticeView.layer.cornerRadius = 6;
        _noticeView.layer.shadowColor = [UIColor colorWithRed:30/255.0 green:141/255.0 blue:255/255.0 alpha:0.1000].CGColor;
        _noticeView.layer.shadowOffset = CGSizeMake(0,1);
        _noticeView.layer.shadowOpacity = 1;
        _noticeView.layer.shadowRadius = 10;
        
        UIImageView *noticeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_notice"]];
        [_noticeView addSubview:noticeIcon];
        [noticeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_noticeView).offset(12);
            make.centerY.equalTo(_noticeView.mas_centerY).offset(0);
            make.width.height.offset(12.5);
        }];
        
        UIImageView *noticeLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_notice"]];
        [_noticeView addSubview:noticeLabel];
        [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(noticeIcon.mas_right).offset(7.5);
            make.centerY.equalTo(_noticeView.mas_centerY).offset(0);
            make.width.offset(33);
            make.height.offset(13);
        }];

        UIView *Line = [UIView new];
        Line.backgroundColor = [UIColor colorWithHexString:@"#1E8DFF" alpha:0.5];
        [_noticeView addSubview:Line];
        [Line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_noticeView.mas_centerY).offset(0);
            make.left.equalTo(noticeLabel.mas_right).offset(12);
            make.height.offset(14.5);
            make.width.offset(0.5);
        }];

        self.noticeLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"您有1个案件待审查，请及时处理";
            label.numberOfLines = 1;
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor colorWithHexString:@"#414955"];
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0f];
            [_noticeView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(Line.mas_right).offset(12);
                make.right.equalTo(_noticeView).offset(-10);
                make.centerY.equalTo(_noticeView.mas_centerY).offset(0);
            }];

            label;
        });
    }
    return _noticeView;
}


@end
