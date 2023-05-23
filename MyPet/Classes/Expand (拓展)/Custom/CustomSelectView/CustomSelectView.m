//
//  CustomSelectView.m
//  MyPet
//
//  Created by long on 2021/9/13.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "CustomSelectView.h"
#import "UIColor+hexColor.h"
#import "CustomSelectViewCell.h"

@interface CustomSelectView ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UIView *contenView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSTextAlignment titleTextAlignment;

@end

@implementation CustomSelectView

- (instancetype)initWithTitle:(NSString *)title addData:(NSArray *)array textAlignment:(NSTextAlignment)textAlignment {
    self = [super init];
    if (self) {
        self.title = title;
        self.dataArray = array;
        self.titleTextAlignment = textAlignment;
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.5];
        [self initView];
        
    }
    return self;
}


- (void)initView {
    self.window = [UIApplication sharedApplication].keyWindow;
    [self.window addSubview:self];
    
    self.contenView = ({
        UIView *contenView = [UIView new];
        contenView.backgroundColor = color_white;
        contenView.layer.cornerRadius = 10;
        contenView.layer.masksToBounds = YES;
        [self addSubview:contenView];
        contenView.frame = CGRectMake(0, Screen_Height, Screen_Width, 450+Bottom_SafeHeight);
        contenView;
    });
    
    UIImageView *topIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"custom_line"]];
    [self.contenView addSubview:topIcon];
    [topIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@8);
        make.centerX.equalTo(self.contenView.mas_centerX).offset(0);
        make.width.offset(36);
        make.height.offset(4);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = self.title;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor colorWithHexString:@"#1A1A1A"];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16.0f];
    [self.contenView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contenView).offset(24);
        make.left.equalTo(self.contenView).offset(20);
        make.right.equalTo(self.contenView).offset(-20);
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [self.contenView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.left.equalTo(self.contenView).offset(20);
        make.top.equalTo(titleLabel.mas_bottom).offset(15);
        make.right.equalTo(self.contenView).offset(-20);
    }];

    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] init];
        tableView.backgroundColor = color_white;
        tableView.estimatedRowHeight = 56;
        [tableView registerNib:[UINib nibWithNibName:@"CustomSelectViewCell" bundle:nil] forCellReuseIdentifier:@"CustomSelectViewCell"];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tableFooterView = [UIView new];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.contenView addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(titleLabel.mas_bottom).offset(16);
            make.bottom.equalTo(self.contenView).offset(-Bottom_SafeHeight);
        }];
        
        tableView;
    });
}

#pragma mark - tableView Delegate/DateSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomSelectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomSelectViewCell"];
    cell.model = self.dataArray[indexPath.row];
    cell.titleTextAlignment = self.titleTextAlignment;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataArray enumerateObjectsUsingBlock:^(CustomSelectViewModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == indexPath.row) {
            model.isSelect = YES;
        } else {
            model.isSelect = NO;
        }
    }];
    [self.tableView reloadData];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.contenView.frame = CGRectMake(0, Screen_Height, Screen_Width, 450+Bottom_SafeHeight);
    } completion:^(BOOL finished) {
        if (self.didSelectItemBlock) {
            self.didSelectItemBlock(indexPath.row);
        }
        [self removeAllView];
    }];

}


// MARK: - function
- (void)show {
    self.hidden = NO;
    [UIView animateWithDuration:0.3f animations:^{
        self.contenView.frame = CGRectMake(0, Screen_Height - (450+Bottom_SafeHeight), Screen_Width, 450+Bottom_SafeHeight);
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.3f animations:^{
        self.contenView.frame = CGRectMake(0, Screen_Height, Screen_Width, 450+Bottom_SafeHeight);
    } completion:^(BOOL finished) {
        [self removeAllView];
    }];
}

- (void)removeAllView {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hide];
}

@end
