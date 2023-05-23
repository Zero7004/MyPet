//
//  PayTableViewCell.m
//  MyPet
//
//  Created by 王健龙 on 2020/4/29.
//  Copyright © 2020 王健龙. All rights reserved.
//

#import "PayTableViewCell.h"

@interface PayTableViewCell ()
/// 选中按钮
@property (strong ,nonatomic) UIButton *selectButton;
@end

@implementation PayTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.frame = CGRectMake(16, 11, 28, 28);
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(60, 0, 100, 21);
    self.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.titleLabel.textColor = color_51;
    self.titleLabel.centerY = self.iconImageView.centerY;
    [self.contentView addSubview:self.titleLabel];
    
    self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectButton.frame = CGRectMake(SCREEN_WIDTH - 16 - 20, 0, 22, 22);
    self.selectButton.userInteractionEnabled = NO;
    [self.selectButton setImage:[UIImage imageNamed:@"pay_selcet_n"] forState:UIControlStateNormal];
    [self.selectButton setImage:[UIImage imageNamed:@"pay_selcet_s"] forState:UIControlStateSelected];
    self.selectButton.centerY = self.iconImageView.centerY;
    [self.contentView addSubview:self.selectButton];
}

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    [self.selectButton setSelected:isSelect];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected stat
}

@end
