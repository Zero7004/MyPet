//
//  CustomProvisionsVC.m
//  MyPet
//
//  Created by long on 2021/9/8.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "CustomProvisionsVC.h"
#import "UIColor+hexColor.h"

@interface CustomProvisionsVC ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation CustomProvisionsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self setProvisionsContent];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(18);
            make.left.equalTo(self.view).offset(16);
            make.right.equalTo(self.view).offset(-16);
            make.width.offset(Screen_Width - 32);
            make.bottom.equalTo(self.view).offset(0);
        }];
        
        scrollView;
    });

    self.contentView = ({
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = 6;
        contentView.layer.masksToBounds = YES;
        [self.scrollView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.right.equalTo(@0);
            make.width.offset(Screen_Width - 32);
            make.bottom.mas_greaterThanOrEqualTo(0);
        }];
        
        contentView;
    });
    
    self.contentLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"";
        label.numberOfLines = 0;
        label.textColor = [UIColor colorWithHexString:@"#1F2733"];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.0f];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.contentView).offset(0);
        }];
        
        label;
    });
}

- (void)setProvisionsContent {
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.ProvisionsContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.contentLabel.attributedText = attrStr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


@end
