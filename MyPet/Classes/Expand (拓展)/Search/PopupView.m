//
//  PopupView.m
//  Loans_Users
//
//  Created by 王健龙 on 2019/5/30.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "PopupView.h"
#import "PopupTableViewCell.h"

#import "PopupModel.h"
#import "UIColor+hexColor.h"

@interface PopupView () <UITableViewDelegate,UITableViewDataSource>

/// 选择tablew
@property (strong ,nonatomic) UITableView *selectTableView;
/// 选中的行
@property (strong ,nonatomic) NSIndexPath *selectIndexPach;
@end

@implementation PopupView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = frame;
    }
    return self;
}

- (void)show {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake((93/2) - 6 + 16, 10)];
    [path addLineToPoint:CGPointMake(93/2 + 16, 0)];
    [path addLineToPoint:CGPointMake((93/2) + 6 + 16, 10)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];

    [self addSubview:self.selectTableView];
    [self.selectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self).offset(6);
        make.width.offset(93);
        make.height.offset(self.selectArray.count * 36);
    }];
    [self.selectTableView layoutIfNeeded];
    
    self.layer.shadowColor = [UIColor colorWithHexString:@"#DBEAFF"].CGColor;//阴影颜色
    self.layer.shadowOpacity = 0.8;//阴影透明度，默认为0，如果不设置的话看不到阴影，切记，这是个大坑
    self.layer.shadowOffset = CGSizeMake(0, 0);//设置偏移量
    self.layer.cornerRadius = 8.0;
    self.layer.shadowRadius = 8.0;
}

- (void)hide {
//    [UIView animateWithDuration:1 animations:^{
//        self.center = CGPointMake(SCREEN_WIDTH / 2, 0);
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
    
    [self removeFromSuperview];
    
}

#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PopupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"popu"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.popupModel = self.selectArray[indexPath.row];
    [cell isLastIndex:indexPath.row == (self.selectArray.count - 1) ? YES : NO ];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //会出现两个同时标记选中的状态
    NSMutableArray *tempArray = [NSMutableArray array];
    for (PopupModel *lastPopuModel in self.selectArray) {
        lastPopuModel.isSelect = NO;
        [tempArray addObject:lastPopuModel];
    }
    self.selectArray = tempArray;
    
    PopupModel *popuModel = self.selectArray[indexPath.row];
    popuModel.isSelect = YES;
    self.selectArray[indexPath.row] = popuModel;
    [self.selectTableView reloadData];
    
    if (self.selectBlock) {
        self.selectBlock(popuModel,self.selectArray);
    }
    
    self.selectIndexPach = indexPath;
}


- (void)setSelectArray:(NSMutableArray *)selectArray {
    _selectArray = selectArray;
    
    [self show];
}


- (UITableView *)selectTableView {
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
        _selectTableView.rowHeight = 36;
        _selectTableView.backgroundColor = [UIColor whiteColor];
        _selectTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _selectTableView.tableFooterView = [UIView new];
        [_selectTableView registerClass:[PopupTableViewCell class] forCellReuseIdentifier:@"popu"];
    }
    return _selectTableView;
}

- (NSIndexPath *)selectIndexPach {
    if (!_selectIndexPach) {
        _selectIndexPach = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return _selectIndexPach;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"点击空白处");
    [self hide];
}

@end
