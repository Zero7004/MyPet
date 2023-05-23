//
//  SearchButtonView.m
//  Loans_Users
//
//  Created by 王健龙 on 2019/5/29.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "SearchButtonView.h"
#import "SearchKeyModel.h"
#import "UIColor+hexColor.h"
#import "UIButton+LXMImagePosition.h"

@interface SearchButtonView ()<UITextFieldDelegate>

@end

@implementation SearchButtonView

- (instancetype)initWithFrame:(CGRect)frame selectTitle:(NSString *)selectTitle clikc:(nonnull void (^)(void))clikc {
    if (self = [super initWithFrame:frame]) {
        
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithHexString:@"#F5F7FA"];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.height /2 ;
        
        //选择按钮
        UIButton * selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectButton.tag = 211;
        selectButton.frame = CGRectMake(0, 0, 100, self.height);
        selectButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0f];
        [selectButton setImage:[UIImage imageNamed:@"home_arrow_down"] forState:UIControlStateNormal];
        [selectButton setTitle:selectTitle forState:UIControlStateNormal];
        [selectButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        //按钮文字居左
        [selectButton setImagePosition:LXMImagePositionRight spacing:5];
        [[selectButton rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(__kindof UIControl * _Nullable x) {
            clikc();
        }];
        [self addSubview:selectButton];
        
        //分割线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(100, 9, 0.5, 16)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#979797"];
        [self addSubview:lineView];
                
        //输入框
        UITextField *textField = [[UITextField alloc] init];
        textField.tag = 993;
        textField.frame = CGRectMake(lineView.x + 10, 0, self.width - 100, self.height);
        textField.font = [UIFont systemFontOfSize:14];
        textField.delegate = self;
        textField.tintColor = color_TabBar_Color;
        textField.textColor = [UIColor colorWithHexString:@"#1F2733"];
//        textField.clearButtonMode = UITextFieldViewModeAlways;
        textField.returnKeyType = UIReturnKeySearch;
        [self addSubview:textField];
    }
    return self;
}

- (void)setSelectTitle:(NSString *)selectTitle {
    _selectTitle = selectTitle;
    UIButton *selectButton = (UIButton *)[self viewWithTag:211];
    [selectButton setTitle:selectTitle forState:UIControlStateNormal];
    [selectButton setImagePosition:LXMImagePositionRight spacing:5];
}

- (void)setType:(NSString *)type {
    _type = type;
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    SearchKeyModel *model = [SearchKeyModel new];
    model.type = self.type;
    model.keyword = textField.text;
    self.searchContentBlock(model);
    [self endEditing:YES];
    return YES;
}

- (void)setSearchContentText:(NSString *)searchContentText {
    UITextField *textField = (UITextField *)[self viewWithTag:993];
    textField.text = searchContentText;
}
@end
