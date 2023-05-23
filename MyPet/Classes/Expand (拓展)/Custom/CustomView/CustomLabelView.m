//
//  CustomLabelView.m
//  MyPet
//
//  Created by long on 2021/7/25.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "CustomLabelView.h"
#import "UIColor+hexColor.h"

@interface CustomLabelView ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIImageView *titleIconIMG;
@property (nonatomic, strong) UIImageView *valueIconIMG;
@end

@implementation CustomLabelView

- (instancetype)initWithDataModel:(CustomLabelViewModel *)model {
    
    self = [super init];
    if (self){
        [self createUIWithDataModel:model];
    }
    return self;
}

- (void)createUIWithDataModel:(CustomLabelViewModel *)model {
    
    if (model.title) {
        self.leftLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = model.title;
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = model.titleColor ? [UIColor colorWithHexString:model.titleColor] : [UIColor colorWithHexString:@"#999999"];
            label.font = model.titleFont ?: [UIFont fontWithName:@"PingFangSC-Regular" size:15.0f];
            [self addSubview:label];
            CGFloat width = [self getWidthWithText:label.text height:18 font:label.font];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(model.space ?: 18);
                make.left.equalTo(self).offset(16);
                make.width.offset(width + 10);
                if (!model.bottomLine) {
                    make.bottom.lessThanOrEqualTo(self).offset(0);
                }
            }];

            label;
        });
    }
    
    if (model.titleIcon) {
        self.titleIconIMG = ({
            UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:model.titleIcon]];
            [self addSubview:imageV];
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.leftLabel.mas_centerY).offset(0);
                make.left.equalTo(self.leftLabel.mas_right).offset(2.5);
                make.width.offset(14);
                make.height.offset(14);
            }];
            imageV;
        });
    }
    
    if (model.valueIcon) {
        self.valueIconIMG = ({
            UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:model.valueIcon]];
            [self addSubview:imageV];
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.leftLabel.mas_centerY).offset(0);
                make.right.equalTo(self).offset(-16);
                make.width.offset(35);
                make.height.offset(14);
//                if (!model.bottomLine) {
//                    make.bottom.equalTo(self).offset(0);
//                }
            }];
            imageV;
        });
    }

    if (model.value) {
        self.rightLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = model.value;
            label.textAlignment = NSTextAlignmentRight;
            label.numberOfLines = 0;
            label.textColor = model.valueColor ? [UIColor colorWithHexString:model.valueColor] : [UIColor colorWithHexString:@"#1F2733"];
            label.font = model.valueFont ?: [UIFont fontWithName:@"PingFangSC-Regular" size:15.0f];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(model.space ?: 18);
                if (model.valueIcon) {
                    make.right.equalTo(self.valueIconIMG.mas_left).offset(-5);
                } else {
                    make.right.equalTo(self).offset(-16);
                }
                make.left.equalTo(self.leftLabel.mas_right).offset(5);
                if (!model.bottomLine) {
                    make.bottom.equalTo(self).offset(0);
                }
            }];

            label;
        });
    }
    
    if (model.bottomLine) {
        UIView *line = [UIView new];
        line.backgroundColor = color_Line_Color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.rightLabel) {
                make.top.equalTo(self.rightLabel.mas_bottom).offset(model.space ?: 18);
            } else {
                make.top.equalTo(self).offset(model.space ?: 18);
            }
            make.left.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
            make.height.offset(1);
            make.bottom.equalTo(self).offset(0);
        }];
    }
}

//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(UIFont *)font{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil];
    return rect.size.width;
}

@end
