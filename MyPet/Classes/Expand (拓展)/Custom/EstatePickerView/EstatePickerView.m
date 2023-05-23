//
//  EstatePickerView.m
//  MyPet
//
//  Created by 王健龙 on 2019/7/18.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "EstatePickerView.h"

#import "EstateModel.h"

#define PickHeight (230)
@interface EstatePickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIButton *grayBtn;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *bgView;
/// 类型
@property (assign ,nonatomic) PickerViewType type;
/// 数组
@property (strong ,nonatomic) NSMutableArray *tempArray;
/// 选中的行
@property (assign ,nonatomic) NSInteger selectIndex;
/// 地产公司ID
@property (strong ,nonatomic) NSString *companyId;
@end

@implementation EstatePickerView

- (instancetype)initWithType:(PickerViewType)type {
    if (self = [super init]) {
        self.hidden = YES;
        [self creatView];
        self.type = type;
        [self loadData];
    }
    return self;
}

- (instancetype)initWithType:(PickerViewType)type CompanyId:(NSString *)companyId {
    if (self = [super init]) {
        self.hidden = YES;
        self.companyId = companyId;
        [self creatView];
        self.type = type;
        [self loadData];
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
        
        if (self.didSelectItemBlock) {
            EstateModel *model = self.tempArray[self.selectIndex];
            // 返回名称ID
            self.didSelectItemBlock(model.intermediaryInstitutions, model.estateId);
        }
    }
    [self hide];
}

- (void)loadData {
    
    NSString *path;
    NSDictionary *parameters = [NSDictionary dictionary];
    if (self.type == caseTypeList) {
        // 获取地产公司列表
        path = @"/agency/groupList";
    } else {
        // 获取案件类型
        path = @"/agency/list";
        parameters = @{
                       @"id":self.companyId?:@"",
                       };
    }
    
    [[KLNetworking shareManager] sendRequestMethod:HTTPMethodGET path:path parameters:parameters success:^(BOOL isSuccess, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == RequestSuccess) {
            self.tempArray = [EstateModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.pickerView reloadAllComponents];
        } else {
            [Tools handleServerStatusCodeDictionary:responseObject];
        }
    } failure:^(id  _Nonnull error) {
        
    }];
    
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
    
    EstateModel *model = self.tempArray[row];
    // 获取公司名称
    pickerLabel.text = model.intermediaryInstitutions;
    return pickerLabel;
}

// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.tempArray.count;
}

#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.width;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30.f;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectIndex = row;
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
@end
