//
//  CustomTextView.m
//  MyPet
//
//  Created by long on 2021/7/24.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "CustomTextView.h"
#import "UIColor+hexColor.h"

@interface CustomTextView ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *valueTF;
@property (nonatomic, strong) UILabel *valueLab;
@property (nonatomic, strong) UIImageView *rightIcon;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation CustomTextView

- (instancetype)initWithCustomTextViewModel:(CustomTextViewModel *)model{
    
    self = [super init];
    if (self){
        _model = model;
        [self initViewWith:model];
    }
    return self;
}

- (void)initViewWith:(CustomTextViewModel *)model {
    self.backgroundColor = [UIColor whiteColor];
        
    self.titleLabel = ({
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = model.title;
        titleLabel.numberOfLines = 2;
        titleLabel.textColor = [UIColor colorWithHexString:model.titleColor ?: @"#1F2733"];
        titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15.0f];
        [self addSubview:titleLabel];
        CGFloat width = [self getWidthWithText:model.title height:18 font:[UIFont fontWithName:@"PingFangSC-Medium" size:15.0f]];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(0);
            if (model.redStar) {
                make.left.equalTo(self).offset(16 + 8);
            } else {
                make.left.equalTo(self).offset(16);
            }
            make.width.offset(width+10);
        }];
    
        titleLabel;
    });
    
    if (model.redStar) {
        UILabel *lable = [[UILabel alloc] init];
        lable.text = @"*";
        lable.textColor = [UIColor colorWithHexString:@"#FF0000"];
        lable.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15.0f];
        [self addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.top.equalTo(self.titleLabel.mas_top).offset(0);
        }];
    }

    
    if (model.viewType == CustomTextViewType_TF) {
        
        if (model.rightStr) {
            self.rightLabel = ({
                UILabel *valueLab = [[UILabel alloc] init];
                valueLab.text = model.rightStr;
                valueLab.textColor = [UIColor colorWithHexString:@"#1F2733"];
                valueLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15.0f];
                valueLab.adjustsFontSizeToFitWidth = YES;
                [self addSubview:valueLab];
                CGFloat width = [self getWidthWithText:model.rightStr height:18 font:[UIFont fontWithName:@"PingFangSC-Medium" size:15.0f]];
                [valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.mas_centerY).offset(0);
                    make.right.equalTo(self).offset(-16);
                    make.width.offset(width);
                }];
            
                valueLab;
            });
        }
        
        self.valueTF = ({
            UITextField *textField = [[UITextField alloc] init];
            textField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.0f];
            textField.placeholder = model.placeholder;
            textField.delegate = self;
            textField.textColor = [UIColor colorWithHexString:model.valueColor ?: @"#1F2733"];
            textField.textAlignment = NSTextAlignmentRight;
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:textField.placeholder attributes:
                @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#A1A8B3"],
                            NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:15.0f]
            }];
            textField.attributedPlaceholder = attrString;
            
            if (model.keyboardType) {
                textField.keyboardType = model.keyboardType;
            }
            [self addSubview:textField];
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(0);
                make.left.equalTo(self.titleLabel.mas_right).offset(10);
                if (model.rightStr) {
                    make.right.equalTo(self.rightLabel.mas_left).offset(-8);
                } else {
                    make.right.equalTo(self).offset(-16);
                }
            }];

            textField;
        });
        
    } else if (model.viewType == CustomTextViewType_Lab) {
        
        self.valueLab = ({
            UILabel *valueLab = [[UILabel alloc] init];
            valueLab.text = model.value;
            valueLab.textColor = [UIColor colorWithHexString:model.valueColor ?: @"#1F2733"];
            valueLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.0f];
            valueLab.textAlignment = NSTextAlignmentRight;
            valueLab.numberOfLines = 2;
            [self addSubview:valueLab];
            [valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(0);
                make.left.equalTo(self.titleLabel.mas_right).offset(10);
                make.right.equalTo(self).offset(-16);
            }];
        
            valueLab;
        });
        
//        self.userInteractionEnabled = YES;
//        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
//        [self addGestureRecognizer:labelTapGestureRecognizer];


    } else if (model.viewType == CustomTextViewType_Sel) {

        self.rightIcon = ({
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"base_next"];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(0);
                make.right.equalTo(self).offset(-16);
                make.width.offset(7);
                make.height.offset(11.9);
            }];
            imageView;
        });
        
        self.valueLab = ({
            UILabel *valueLab = [[UILabel alloc] init];
            valueLab.text = model.placeholder;
            valueLab.textColor = [UIColor colorWithHexString:@"#A1A8B3"];
            valueLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.0f];
            valueLab.textAlignment = NSTextAlignmentRight;
            [self addSubview:valueLab];
            [valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(0);
                make.left.equalTo(self.titleLabel.mas_right).offset(10);
                make.right.equalTo(self.rightIcon.mas_left).offset(-7);
            }];
        
            valueLab;
        });
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
        [self addGestureRecognizer:labelTapGestureRecognizer];

    } else if (model.viewType == CustomTextViewType_options) {
        
        UIButton *lastBtn;
        for (int i = (int)(model.optionsArray.count - 1); i >= 0; i--) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:model.optionsArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexString:@"#3D4E66"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"TC_NoSelect"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"TC_select"] forState:UIControlStateSelected];
//            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.0f];
            [btn setSelected:NO];
            if (model.valueKey.length > 0 && [model.valueKey intValue] == i) {
                [btn setSelected:YES];
            }
            [self addSubview:btn];
            CGFloat width = [self getWidthWithText:model.optionsArray[i] height:55 font:[UIFont fontWithName:@"PingFangSC-Regular" size:15.0f]];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).offset(0);
                make.width.offset(width+22);
                if (lastBtn) {
                    make.right.equalTo(lastBtn.mas_left).offset(-16);
                } else {
                    make.right.equalTo(self).offset(-16);
                }
                if (i == 0) {
                    make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(10);
                }
            }];
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                [self.buttonArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
                    [button setSelected:NO];
                    if (button == btn) {
                        model.valueKey = [NSString stringWithFormat:@"%ld", idx];
                        if (self.SelectClickBlock) {
                            self.SelectClickBlock(i);
                        }
                    }
                }];
                [btn setSelected:!btn.isSelected];
            }];
            lastBtn = btn;
            [self.buttonArray insertObject:btn atIndex:0];
        }
        
    }
    
    if (model.addBottomLine) {
        self.bottomLine = ({
            UIView *bottomLine = [UIView new];
            bottomLine.backgroundColor = color_Line_Color;
            [self addSubview:bottomLine];
            [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mas_bottom).offset(0);
                make.left.equalTo(self).offset(16);
                make.right.equalTo(self).offset(-16);
                make.height.offset(1);
            }];
            
            bottomLine;
        });
    }
}

// MARK: - function
- (void)labelTouchUpInside:(UITapGestureRecognizer *)recognizer {
    if (self.TextViewClickBlock) {
        self.TextViewClickBlock();
    }
}

- (void)updateCustomTextView:(NSString *)valueStr {
    if (valueStr.length > 0) {
        self.valueLab.textColor = [UIColor colorWithHexString:self.model.valueColor ?: @"#1F2733"];
        self.valueLab.text = valueStr;
        self.model.value = valueStr;
    } else {
        self.valueLab.textColor = [UIColor colorWithHexString:@"#A1A8B3"];
        self.valueLab.text = self.model.placeholder;
        self.model.value = @"";
        self.model.valueKey = @"";
    }
}

- (void)updateCustomValue:(NSString *)valueStr valueKey:(NSString *)valueKey {
    self.valueLab.textColor = [UIColor colorWithHexString:self.model.valueColor ?: @"#1F2733"];
    self.valueLab.text = valueStr;
    self.model.value = valueStr;
    self.model.valueKey = valueKey;
}

- (void)updateCustomTextFieldView:(NSString *)valueStr {
    self.valueTF.text = valueStr;
    self.model.value = valueStr;
    self.model.valueKey = valueStr;
}

- (void)updateCustomTitleView:(NSString *)titleStr {
    self.titleLabel.text = titleStr;
}

- (void)updateCustomValue:(NSString *)valueStr {
    self.model.valueKey = valueStr;
}



//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(UIFont *)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil];
    return rect.size.width;
}

// MARK: - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.model.value = textField.text;
    self.model.valueKey = textField.text;
    if (self.TextFieldEndEditBlock) {
        self.TextFieldEndEditBlock(textField.text);
    }
}

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray new];
    }
    return _buttonArray;
}

@end
