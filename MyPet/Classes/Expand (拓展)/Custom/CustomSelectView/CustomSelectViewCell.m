//
//  CustomSelectViewCell.m
//  MyPet
//
//  Created by long on 2021/9/13.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "CustomSelectViewCell.h"
#import "CustomSelectViewModel.h"
#import "UIColor+hexColor.h"

@interface CustomSelectViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *rightIcon;

@end

@implementation CustomSelectViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setModel:(CustomSelectViewModel *)model {
    _model = model;
    
    self.titleL.text = model.title;
    self.rightIcon.hidden = !model.isSelect;
    if (model.isSelect) {
        self.titleL.textColor = [UIColor colorWithHexString:@"#006AFF"];
    } else {
        self.titleL.textColor = [UIColor colorWithHexString:@"#1A1A1A"];
    }
}

- (void)setTitleTextAlignment:(NSTextAlignment)titleTextAlignment {
    self.titleL.textAlignment = titleTextAlignment;
}

@end
