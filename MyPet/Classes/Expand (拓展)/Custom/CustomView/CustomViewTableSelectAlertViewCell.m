//
//  CustomViewTableSelectAlertViewCell.m
//  MyPet
//
//  Created by long on 2021/8/2.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "CustomViewTableSelectAlertViewCell.h"
#import "CustomViewTableSelectAlertView.h"
#import "UIColor+hexColor.h"

@interface CustomViewTableSelectAlertViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *rightIcon;


@end

@implementation CustomViewTableSelectAlertViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CustomSelModel *)model {
    self.titleL.text = model.title;
    self.rightIcon.hidden = !model.isSelect;
    if (model.isSelect) {
        self.titleL.textColor = [UIColor colorWithHexString:@"#006AFF"];
        self.titleL.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15.0f];
    } else {
        self.titleL.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.0f];
        self.titleL.textColor = [UIColor colorWithHexString:@"#1A1A1A"];
    }
}

@end
