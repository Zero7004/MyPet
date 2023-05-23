//
//  RegionPickerView.m
//  MyPet
//
//  Created by long on 2021/10/29.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "RegionPickerView.h"
#import "AreaModel.h"

#define PickHeight (230)

@interface RegionPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIButton *grayBtn;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSArray<RegionChildrenDataModel> *AreaData;

@property (nonatomic, strong) NSMutableArray *provinceArr;
@property (nonatomic, strong) NSMutableArray *cityArr;
@property (nonatomic, strong) NSMutableArray *areaArr;

@property (nonatomic, assign) NSUInteger provinceIndex;
@property (nonatomic, assign) NSUInteger cityIndex;
@property (nonatomic, assign) NSUInteger areaIndex;
@end

@implementation RegionPickerView

- (instancetype)initWithRegionData:(NSArray<RegionChildrenDataModel> *)dataArray {
    self = [super init];
    if (self) {
        self.AreaData = dataArray;
        [self setupData];
        [self initUI];
    }
    return self;
}

- (void)setupData {
    [self.provinceArr addObjectsFromArray:self.AreaData];
    RegionChildrenDataModel *provinceModel = self.provinceArr.firstObject;
    [self.cityArr addObjectsFromArray:provinceModel.children];
    RegionChildrenDataModel *cityModel = self.cityArr.firstObject;
    [self.areaArr addObjectsFromArray:cityModel.children];
}

- (void)initUI {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    self.frame = window.bounds;
    [window addSubview:self];
    
    self.grayBtn = [[UIButton alloc] initWithFrame:self.bounds];
    self.grayBtn.backgroundColor=[UIColor blackColor];
    self.grayBtn.alpha = 0.2;
    [self addSubview:self.grayBtn];
    
    [self.bgView addSubview:self.pickerView];
    [self.bgView addSubview:self.titleLabel];
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
        if (self.didSelectItemBlock){
            RegionChildrenDataModel *provinceModel = self.provinceArr[self.provinceIndex];
            RegionChildrenDataModel *cityModel = self.cityArr[self.cityIndex];
            RegionChildrenDataModel *areaModel = self.areaArr[self.areaIndex];
            NSString *address = [NSString stringWithFormat:@"%@ %@ %@", provinceModel.name, cityModel.name, areaModel.name];
            self.didSelectItemBlock(address, areaModel.id);
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
    
    NSArray *arr = @[self.provinceArr, self.cityArr, self.areaArr];
    RegionChildrenDataModel *model = arr[component][row];
    pickerLabel.text = model.name;
    
    return pickerLabel;
}

// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.areaArr.count) {
        return 3;
    } else if (self.cityArr.count) {
        return 2;
    }
    return 1;
}
// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *arr = @[self.provinceArr, self.cityArr, self.areaArr];
    NSArray *temp = arr[component];
    return [temp count];
}

#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (self.areaArr.count) {
        return self.width/3;
    }
    return self.width/2;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30.f;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0: [self choiceProvinceIndex:row];   break;
        case 1: [self choiceCityIndex:row];   break;
        case 2: {
            self.areaIndex = row;
        }   break;
        default:  break;
    }
    
    [self setTitleLabelStr];
}

- (void)choiceProvinceIndex:(NSUInteger)row {
    self.provinceIndex = row;
    
    NSArray *cityArray = ((RegionChildrenDataModel *)self.provinceArr[row]).children;
    if (cityArray.count){
        [self.cityArr removeAllObjects];
        [self.cityArr addObjectsFromArray:cityArray];
        
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        
        NSArray *areaArray = ((RegionChildrenDataModel *)self.cityArr.firstObject).children;
        if (areaArray.count){
            [self.areaArr removeAllObjects];
            [self.areaArr addObjectsFromArray:areaArray];
            
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
        }else{
            [self.areaArr removeAllObjects];
        }
    }else{
        [self.cityArr removeAllObjects];
        [self.areaArr removeAllObjects];
    }
    self.cityIndex = 0;
    self.areaIndex = 0;
    
    if (self.areaArr.count) {
        [self.pickerView reloadComponent:2];
        [self.pickerView reloadComponent:1];
    } else if (self.cityArr.count) {
        [self.pickerView reloadComponent:1];
    } else {
        [self.pickerView reloadComponent:0];
    }
    
}
- (void)choiceCityIndex:(NSUInteger)row {
    self.cityIndex = row;
    
    if (self.cityArr.count){
        NSArray *areaArray = ((RegionChildrenDataModel *)self.cityArr[row]).children;
        if (areaArray.count){
            [self.areaArr removeAllObjects];
            [self.areaArr addObjectsFromArray:areaArray];
            
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
        }else{
            [self.areaArr removeAllObjects];
        }
        self.areaIndex = 0;
        if (self.areaArr.count) {
             [self.pickerView reloadComponent:2];
        }
       
    }
}



- (void)setTitleLabelStr {
    NSString *provStr, *cityStr, *areaStr;
    if (self.provinceArr.count) {
        provStr = ((RegionChildrenDataModel *)self.provinceArr[self.provinceIndex]).name;
    }
    
    if (self.cityArr.count) {
         cityStr = ((RegionChildrenDataModel *)self.cityArr[self.cityIndex]).name;
    }
    if (self.areaArr.count) {
        areaStr = ((RegionChildrenDataModel *)self.areaArr[self.areaIndex]).name;
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@ %@ %@", provStr?:@"", cityStr?:@"", areaStr?:@""];
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
- (UILabel *)titleLabel {
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(66, 10, self.bgView.width-66*2, 24)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (NSMutableArray *)provinceArr {
    if(!_provinceArr){
        _provinceArr = [NSMutableArray array];
    }
    return _provinceArr;
}
- (NSMutableArray *)cityArr {
    if (!_cityArr){
        _cityArr = [NSMutableArray array];
    }
    return _cityArr;
}
-(NSMutableArray *)areaArr {
    if (!_areaArr){
        _areaArr = [NSMutableArray array];
    }
    return _areaArr;
}

@end
