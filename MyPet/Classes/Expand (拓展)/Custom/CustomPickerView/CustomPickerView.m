//
//  CustomPickerView.m
//  MyPet
//
//  Created by long on 2021/8/9.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "CustomPickerView.h"
#define PickHeight (230)

@interface CustomPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIButton *grayBtn;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *bgView;
@property (strong ,nonatomic) NSMutableArray *tempArray;
@property (strong ,nonatomic) NSMutableArray *tempArraySec;
@property (assign ,nonatomic) NSInteger selectIndex;
@property (assign ,nonatomic) NSInteger selectIndexSec;
@property (nonatomic, assign) PickerType pickerType;

@end

@implementation CustomPickerView

- (instancetype)initWithCustomArray:(NSArray *)array {
    if (self = [super init]) {
        self.hidden = YES;
        [self creatView];
        self.tempArray = array.mutableCopy;
        [self.pickerView reloadAllComponents];
    }
    return self;
}

- (instancetype)initWithCustomArray:(NSArray *)array withPickerType:(PickerType)pickerType {
    if (self = [super init]) {
        self.hidden = YES;
        [self creatView];
        self.pickerType = pickerType;
        self.tempArray = array.mutableCopy;
        CustomPickerViewModel *model = self.tempArray[0];
        [self.tempArraySec addObjectsFromArray:model.valueArray];
        [self.pickerView reloadAllComponents];
    }
    return self;
}

- (instancetype)initWithCustomArray:(NSArray *)arrayF Array:(NSArray *)arrayS withPickerType:(PickerType)pickerType {
    if (self = [super init]) {
        self.hidden = YES;
        [self creatView];
        self.pickerType = pickerType;
        self.tempArray = arrayF.mutableCopy;
        self.tempArraySec = arrayS.mutableCopy;
        [self.pickerView reloadAllComponents];
    }
    return self;
}


- (void)creatView {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    self.frame = window.bounds;
    [window addSubview:self];
    
    self.grayBtn = [[UIButton alloc] initWithFrame:self.bounds];
    self.grayBtn.backgroundColor=[UIColor blackColor];
    self.grayBtn.alpha = 0.2;
    [self addSubview:self.grayBtn];
    
    [self.bgView addSubview:self.pickerView];
    [self addSubview:self.bgView];
    
    NSArray *buttons = @[@"取消", @"确定"];
    for (NSInteger i = 0; i < buttons.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(i?(self.width-56-8):8, 9, 56, 26)];
        [btn setTitle:buttons[i] forState:UIControlStateNormal];
        [btn setTitleColor:i?color_TabBar_Color:color_228 forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        btn.tag = 100+i;
        if (i){
            ViewRadius(btn, btn.height/2);
        }
        [self.bgView addSubview:btn];
        [btn addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)topButtonAction:(UIButton *)sender {
    if (sender.tag == 101) {
        if (self.tempArray.count == 0) {
            [self hide];
            return;
        }

        if (self.didSelectItemBlock) {
            CustomPickerViewModel *model = self.tempArray[self.selectIndex];
            self.didSelectItemBlock(model.title, model.value);
        }
        
        if (self.didSelectItemBlockSec) {
            
            if (self.pickerType == PickerType_two) {
                CustomPickerViewModel *model_1 = self.tempArray[self.selectIndex];
                CustomPickerViewModel *model_2;
                if (model_1.valueArray.count > 0) {
                    model_2 = model_1.valueArray[self.selectIndexSec];
                }
                self.didSelectItemBlockSec(model_1.title, model_1.value, model_2.title ?: @"", model_2.value ?: @"");
            } else {
                CustomPickerViewModel *model_1 = self.tempArray[self.selectIndex];
                CustomPickerViewModel *model_2 = self.tempArraySec[self.selectIndexSec];
                self.didSelectItemBlockSec(model_1.title, model_1.value, model_2.title, model_2.value);
            }

        }
    }
    [self hide];
}

- (void)show {
    self.hidden = NO;
    [UIView animateWithDuration:0.3f animations:^{
        self.bgView.frame = CGRectMake(0, self.height-PickHeight-BottomSafeAreaHeight, self.bgView.width, self.bgView.height);
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.3f animations:^{
        self.bgView.frame = CGRectMake(0, self.height, self.bgView.width, self.bgView.height);
    } completion:^(BOOL finished) {
        if (self.closeBlock){
            self.closeBlock();
        }
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}

#pragma mark -- UIPickerViewDataSource
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    for(UIView *singleLine in pickerView.subviews){
        if (singleLine.frame.size.height < 1){
            singleLine.backgroundColor = color_228;
        }
    }
    UILabel *pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:18.f]];
    }
    
    if (self.pickerType == PickerType_one) {
        CustomPickerViewModel *model = self.tempArray[row];
        pickerLabel.text = model.title;
    } else {
        if (component == 0) {
            CustomPickerViewModel *model = self.tempArray[row];
            pickerLabel.text = model.title;
        } else {
            CustomPickerViewModel *model = self.tempArraySec[row];
            pickerLabel.text = model.title;
        }
    }

    return pickerLabel;
}

// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.pickerType == PickerType_one) {
        return 1;
    } else {
        return 2;
    }
}
// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.pickerType == PickerType_one) {
        return self.tempArray.count;
    } else {
        if (component == 0) {
            return self.tempArray.count;
        } else {
            return self.tempArraySec.count;
        }
    }
}

#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (self.pickerType == PickerType_one) {
        return self.width;
    } else {
        return self.width / 2;
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30.f;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.pickerType == PickerType_one) {
        self.selectIndex = row;
    } else if (self.pickerType == PickerType_two) {
        if (component == 0) {
            self.selectIndex = row;
            [self.tempArraySec removeAllObjects];
            CustomPickerViewModel *model = self.tempArray[row];
            [self.tempArraySec addObjectsFromArray:model.valueArray];
            [pickerView reloadComponent:1];
        } else {
            self.selectIndexSec = row;
        }
    } else {
        if (component == 0) {
            self.selectIndex = row;
        } else {
            self.selectIndexSec = row;
        }
    }
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 45, self.bgView.width, self.bgView.height-45)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}
- (UIView *)bgView {
    if (!_bgView){
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, PickHeight+BottomSafeAreaHeight)];
        _bgView.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, _bgView.width, 0.5)];
        lineView.backgroundColor = color_228;
        [_bgView addSubview:lineView];
    }
    return _bgView;
}

- (NSMutableArray *)tempArraySec {
    if (!_tempArraySec) {
        _tempArraySec = [NSMutableArray new];
    }
    return _tempArraySec;
}

@end
