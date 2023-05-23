//
//  FunctionListView.m
//  MyPet
//
//  Created by long on 2022/7/20.
//  Copyright © 2022 王健龙. All rights reserved.
//

#import "FunctionListView.h"
#import "CBSegmentView.h"
#import "FunctionCustomView.h"
#import "FunctionCustomDM.h"

@interface FunctionListView ()<UIScrollViewDelegate>

@property (nonatomic, strong) CBSegmentView *segmentView;
@property (strong ,nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FunctionListView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initData];
        [self setupUI];
    }
    return self;
}

- (void)initData {
    self.titles = @[@"工具", @"会员", @"行政", @"资产"];
    NSArray *itmeIcon = @[@"home_function_0", @"home_member_0", @"home_admin_0", @"home_property_0"];
    NSArray *itmeStrings = @[@[@"查学位", @"房贷计算器", @"税费计算器", @"贷款计算器", @"问答百科", @"交易指南"],
                            @[@"产品", @"协议划扣", @"海报分享", @"子账户", @"会员学院"],
                            @[@"征信服务", @"公证服务", @"房管局信息"],
                            @[@"资产处置", @"委托出售"]];
    [self.titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        FunctionCustomDM *dataModel = [FunctionCustomDM new];
        dataModel.title = title;
        NSMutableArray *itmes = NSMutableArray.new;
        NSArray *itmeStrs = itmeStrings[idx];
        NSString *iconStr = itmeIcon[idx];
        for (int i = 0; i < itmeStrs.count; i++) {
            FunctionItmeDM *model = [FunctionItmeDM new];
            model.title = itmeStrs[i];
            model.iconName = [NSString stringWithFormat:@"%@%d", iconStr, i + 1];
            [itmes addObject:model];
        }
        dataModel.itmes = [itmes copy];
        [self.dataArray addObject:dataModel];
    }];
    
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;

    self.segmentView = [[CBSegmentView alloc] initWithFrame:CGRectMake(16, 0, Screen_Width - 32 - 32, 45)];
    [self addSubview:self.segmentView];
    [self.segmentView setTitleArray:self.titles titleFont:[UIFont fontWithName:@"PingFangSC-Regular" size:15.0f] titleSelectFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16.0f] titleColor:[UIColor colorWithHexString:@"#A1A8B3"] titleSelectedColor:[UIColor colorWithHexString:@"#3D4E66"] withStyle:CBSegmentStyleSlider];
    [self.segmentView updateButtonWithWidth:(Screen_Width - 64) btnSpace:5];
    [self.segmentView updateSliderUIWith:30 height:4 color:[UIColor colorWithHexString:@"#1E8DFF"] cornerRadius:2];
    @weakify(self)
    self.segmentView.titleChooseReturn = ^(NSInteger index) {
        @strongify(self)
      NSLog(@"点击了第%ld个按钮", index+1);
        [self.scrollView setContentOffset:CGPointMake((SCREEN_WIDTH - 32) * index, 0) animated:YES];
    };
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = [UIColor colorWithHexString:@"#F5F7FA"];
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentView.mas_bottom).offset(0);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.height.offset(0.5);
    }];

    [self setUpUIScrollView];
}

- (void)setUpUIScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentView.mas_bottom).offset(0);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.width.offset((SCREEN_WIDTH - 32) * self.dataArray.count);
        make.bottom.equalTo(self).offset(0);
    }];
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.scrollView).offset(0);
        make.width.offset((SCREEN_WIDTH - 32) * self.dataArray.count);
    }];
    
    FunctionCustomView *lastView;
    for (int i = 0; i < self.dataArray.count; i++) {
        FunctionCustomDM *dataModel = self.dataArray[i];
        CGSize itmeSize = CGSizeMake((SCREEN_WIDTH - 68) / 4, 107);
        FunctionCustomView *commonView = [[FunctionCustomView alloc] initWithItemSize:itmeSize title:@""];
        [commonView setDataArray:dataModel.itmes itemCount:4];
//        weakify(self)
        commonView.SelectBlock = ^(FunctionItmeDM * _Nonnull model) {
//            @strongify(self)
        };
        [contentView addSubview:commonView];
        [commonView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                make.left.equalTo(lastView.mas_right).offset(0);
            } else {
                make.left.equalTo(contentView).offset(0);
            }
            make.top.equalTo(contentView).offset(0);
            make.bottom.lessThanOrEqualTo(contentView).offset(0);
            if (i == self.dataArray.count - 1) {
                make.right.equalTo(contentView).offset(0);
            }
            make.width.offset(SCREEN_WIDTH - 32);
        }];
        lastView = commonView;
    }
    
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = NSMutableArray.new;
    }
    return _dataArray;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        [self.segmentView setSelectIndex:(self.scrollView.contentOffset.x / (SCREEN_WIDTH - 32))];
    }
}


@end
