//
//  PopupTableViewCell.m
//  Loans_Users
//
//  Created by 王健龙 on 2019/5/30.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "PopupTableViewCell.h"
#import "UIColor+hexColor.h"

@interface PopupTableViewCell ()

/// 标题
@property (copy ,nonatomic) UILabel *selectLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation PopupTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //顶部线条
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self);
            make.left.equalTo(self).offset(11);
            make.right.equalTo(self).offset(-11);
            make.height.equalTo(@0.5);
        }];
        self.lineView = lineView;
    }
    return self;
}

- (void)setPopupModel:(PopupModel *)popupModel {
    self.selectLabel.text = popupModel.title;
    if (popupModel.isSelect) {
        self.selectLabel.textColor = [UIColor colorWithHexString:@"#006AFF"];
    } else {
        self.selectLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    }
}


// 标题懒加载
- (UILabel *)selectLabel {
    if (!_selectLabel) {
        _selectLabel = [[UILabel alloc] init];
        _selectLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0f];
        _selectLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _selectLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_selectLabel];
        [_selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.left.right.equalTo(@0);
        }];
    }
    return _selectLabel;
}


- (void)isLastIndex:(BOOL)isLast {
    self.lineView.hidden = isLast;
}


@end
