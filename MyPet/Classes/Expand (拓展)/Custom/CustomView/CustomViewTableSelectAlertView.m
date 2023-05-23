//
//  CustomViewTableSelectAlertView.m
//  MyPet
//
//  Created by long on 2021/8/2.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "CustomViewTableSelectAlertView.h"
#import "UIColor+hexColor.h"
#import "CustomButtonView.h"
#import "CustomViewTableSelectAlertViewCell.h"

#define AlertViewHeight (405 + Bottom_SafeHeight)

@implementation CustomSelModel

@end




@interface CustomViewTableSelectAlertView ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contenView;
@end

@implementation CustomViewTableSelectAlertView

- (instancetype)initTitle:(NSString *)title dataArray:(NSArray *)dataArray {
    
    self = [super init];
    if (self){
        self.dataArray = dataArray;
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.5];
        [self initViewWithTitle:title];
    }
    return self;
}

- (void)initViewWithTitle:(NSString *)title {
    self.window = [UIApplication sharedApplication].keyWindow;
    [self.window addSubview:self];
    
    self.contenView = ({
        UIView *contenView = [UIView new];
        contenView.backgroundColor = color_white;
        contenView.layer.cornerRadius = 10;
        contenView.layer.masksToBounds = YES;
        [self addSubview:contenView];
        contenView.frame = CGRectMake(0, Screen_Height, Screen_Width, AlertViewHeight);
        
        contenView;
    });
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor colorWithHexString:@"#1A1A1A"];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16.0f];
    [self.contenView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contenView).offset(24);
        make.left.equalTo(self.contenView).offset(20);
        make.centerX.equalTo(self.contenView.mas_centerX).offset(0);
    }];

    UIView *topLine = [UIView new];
    topLine.backgroundColor = color_Line_Color;
    [self.contenView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(16);
        make.left.equalTo(self.contenView).offset(20);
        make.right.equalTo(self.contenView).offset(-20);
        make.height.offset(1);
    }];
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] init];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.estimatedRowHeight = 56;
        [tableView registerNib:[UINib nibWithNibName:@"CustomViewTableSelectAlertViewCell" bundle:nil] forCellReuseIdentifier:@"CustomViewTableSelectAlertViewCell"];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tableFooterView = [UIView new];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.contenView addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(topLine.mas_bottom).offset(0);
            make.bottom.equalTo(self.contenView.mas_bottom).offset(0);
        }];
        
        tableView;
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
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}

#pragma mark - tableView Delegate/DateSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomViewTableSelectAlertViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomViewTableSelectAlertViewCell"];
    [cell setModel:self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.SelectBlock) {
        self.SelectBlock(indexPath.row);
        [self hiddenAlertView];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hiddenAlertView];
}


@end
