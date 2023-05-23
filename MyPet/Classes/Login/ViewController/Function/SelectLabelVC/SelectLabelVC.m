//
//  SelectLabelVC.m
//  MyPet
//
//  Created by long on 2022/7/21.
//  Copyright © 2022 王健龙. All rights reserved.
//

#import "SelectLabelVC.h"
#import "SelectLabelItemView.h"
#import "SelectLabelVM.h"

@interface SelectLabelVC ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) SelectLabelVM *viewModel;

@end

@implementation SelectLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    [self setUpUI];
}

- (void)setupNav {
    self.title = @"选择标签";
}


- (void)setUpUI {
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F7FA"];
    
    self.scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor colorWithHexString:@"#F5F7FA"];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            make.left.right.equalTo(@0);
            make.width.offset(SCREEN_WIDTH);
            make.bottom.mas_equalTo(self.view).offset(-BottomSafeAreaHeight);
        }];
        
        scrollView;
    });

    self.contentView = ({
        UIView *contentView = [UIView new];
        contentView.backgroundColor = [UIColor colorWithHexString:@"#F5F7FA"];
        [self.scrollView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.scrollView).offset(0);
            make.width.offset(SCREEN_WIDTH);
            make.height.greaterThanOrEqualTo(self.scrollView);
        }];
        contentView;
    });

    __block UIView *lastView;
    [self.viewModel.titleArray enumerateObjectsUsingBlock:^(SelectLabeTitleDM *titleModel, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *dataArray;
        if (idx == self.viewModel.titleArray.count - 1) {
            dataArray = [self.viewModel.dataArray subarrayWithRange:NSMakeRange(idx, self.viewModel.titleArray.count)];
        } else {
            dataArray = @[self.viewModel.dataArray[idx]];
        }
        UIView *view = [self createContentlViewWithTitle:titleModel.title SubTitle:titleModel.subTitle dataArray:dataArray];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                make.top.equalTo(lastView.mas_bottom).offset(0);
            } else {
                make.top.equalTo(self.contentView).offset(0);
            }
            make.left.right.equalTo(self.contentView).offset(0);
            if (idx == self.viewModel.titleArray.count - 1) {
                make.bottom.equalTo(self.contentView).offset(-20);
            }
        }];
        lastView = view;
    }];

}

- (UIView *)createContentlViewWithTitle:(NSString *)title
                            SubTitle:(NSString *)subTtile
                           dataArray:(NSArray *)dataArray {
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#F5F7FA"];
        
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor colorWithHexString:@"#1F2733"];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18.0f];
    [bgView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(18);
        make.left.equalTo(bgView).offset(16);
        make.right.equalTo(bgView).offset(-16);
    }];
    
    UILabel *subTitleLabel;
    if (subTtile.length > 0) {
        subTitleLabel = [[UILabel alloc] init];
        subTitleLabel.text = subTtile;
        subTitleLabel.numberOfLines = 0;
        subTitleLabel.textColor = [UIColor colorWithHexString:@"#A1A8B3"];
        subTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0f];
        [bgView addSubview:subTitleLabel];
        [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(8);
            make.left.equalTo(bgView).offset(16);
            make.right.equalTo(bgView).offset(-16);
        }];
    }
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 6;
    contentView.layer.masksToBounds = YES;
    [bgView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (subTitleLabel) {
            make.top.equalTo(subTitleLabel.mas_bottom).offset(16);
        } else {
            make.top.equalTo(titleLabel.mas_bottom).offset(16);
        }
        make.left.equalTo(bgView).offset(16);
        make.right.equalTo(bgView).offset(-16);
        make.bottom.equalTo(bgView).offset(0);
    }];
    
    __block SelectLabelItemView *lastView;
    [dataArray enumerateObjectsUsingBlock:^(SelectLabelDM *dataModel, NSUInteger idx, BOOL * _Nonnull stop) {
        SelectLabelItemView *view = [[SelectLabelItemView alloc] initWithTitle:dataModel.title Width:(Screen_Width - 32) dataArray:dataModel.itmes];
        view.selectType = dataModel.selectType;
        [contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                make.top.equalTo(lastView.mas_bottom).offset(10);
            } else {
                make.top.equalTo(contentView).offset(0);
            }
            make.left.right.equalTo(contentView).offset(0);
            if (idx == dataArray.count - 1) {
                make.bottom.equalTo(contentView).offset(0);
                *stop = YES;
            }
        }];
        
        lastView = view;
    }];

    
    return bgView;
}

- (SelectLabelVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [[SelectLabelVM alloc] init];
    }
    return _viewModel;
}


@end
