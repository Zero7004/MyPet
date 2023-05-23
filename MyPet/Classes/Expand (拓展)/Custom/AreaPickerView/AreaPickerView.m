//
//  AreaPickerView.m
//  MyPet
//
//  Created by 王健龙 on 2019/6/27.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "AreaPickerView.h"
#import "AreaModel.h"

#define PickHeight (230)
@interface AreaPickerView ()  <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIButton *grayBtn;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSMutableArray *provinceArr;
@property (nonatomic, strong) NSMutableArray *cityArr;
@property (nonatomic, strong) NSMutableArray *areaArr;

@property (nonatomic, assign) NSUInteger provinceIndex;
@property (nonatomic, assign) NSUInteger cityIndex;
@property (nonatomic, assign) NSUInteger areaIndex;
@end

@implementation AreaPickerView

- (instancetype)init {
    if (self = [super init]) {
        self.hidden = YES;
        [self creatView];
        [self loadProvinceCity];
    }
    return self;
}

- (instancetype)initWithHouseCity {
    if (self = [super init]) {
        self.hidden = YES;
        [self creatView];
        [self loadHouseCity];
    }
    return self;
}

- (instancetype)initWithArea {
    if (self = [super init]) {
        self.hidden = YES;
        [self creatView];
        [self loadProvinceCityArea];
    }
    return self;
}

- (instancetype)initWithGuangzhou {
    if (self = [super init]) {
        self.hidden = YES;
        [self creatView];
        [self loadProvinceGuangZhouArea];
    }
    return self;
}

// 评估价格选择城市
- (instancetype)initWithSelectProvinceCityAreaAll {
    if (self = [super init]) {
        self.hidden = YES;
        [self creatView];
        [self loadSelectProvinceCityAreaAll];
    }
    return self;
}

// 查册选择城市
- (instancetype)initWithSearchBooklet {
    if (self = [super init]) {
        self.hidden = YES;
        [self creatView];
        [self loadSearchBookletCityArea];
    }
    return self;
}


// 一级联动
- (void)loadHouseCity {
    for (NSDictionary *dict in [Tools getHouseCity]) {
        AreaModel *model = [AreaModel mj_objectWithKeyValues:dict];
        if ([model.name isEqualToString:@"广州市"]) {
            [self.provinceArr addObject:model];
        }
    }
    
    [self.pickerView reloadAllComponents];
}

// 二级联动
- (void)loadProvinceCity {
    
    for (NSDictionary *dict in [Tools getProvinceCity]) {
        AreaModel *model = [AreaModel mj_objectWithKeyValues:dict];
        if ([model.name isEqualToString:@"广东省"]) {
            for (AreaModel *cityModel in model.city) {
                if ([cityModel.name isEqualToString:@"广州市"]) {
                    model.city = [NSArray arrayWithObject:cityModel];
                    [self.provinceArr addObject:model];
                    break;
                }
            }
        }
    }
    
    [self.cityArr addObjectsFromArray:((AreaModel *)self.provinceArr.firstObject).city];
    
    [self.pickerView reloadAllComponents];
    
    [self setTitleLabelStr];
}

// 广州三级联动
- (void)loadProvinceGuangZhouArea {
    
    for (NSDictionary *dict in [Tools getProvinceCityArea]) {
        AreaModel *model = [AreaModel mj_objectWithKeyValues:dict];
        if ([model.name isEqualToString:@"广东省"]) {
            NSMutableArray *tempArray = [NSMutableArray array];
            for (AreaModel *cityModel in model.city) {
                if ([cityModel.name isEqualToString:@"广州市"] || [cityModel.name isEqualToString:@"佛山市"]) {
                    [tempArray addObject:cityModel];
                }
            }
            model.city = tempArray;
            [self.provinceArr addObject:model];
            break;
        }
    }
    
    [self.cityArr addObjectsFromArray:((AreaModel *)self.provinceArr.firstObject).city];
    [self.areaArr addObjectsFromArray:((AreaModel *)self.cityArr.firstObject).area];
    [self.pickerView reloadAllComponents];
    
    [self setTitleLabelStr];
}

// 三级联动
- (void)loadProvinceCityArea {
    
    for (NSDictionary *dict in [Tools getProvinceCityArea]) {
        AreaModel *model = [AreaModel mj_objectWithKeyValues:dict];
        [self.provinceArr addObject:model];
    }
    
    [self.cityArr addObjectsFromArray:((AreaModel *)self.provinceArr.firstObject).city];
    [self.areaArr addObjectsFromArray:((AreaModel *)self.cityArr.firstObject).area];
    [self.pickerView reloadAllComponents];
    
    [self setTitleLabelStr];
}

// 查册地址
- (void)loadSearchBookletCityArea {
    for (NSDictionary *dict in [Tools getProvinceCity]) {
        AreaModel *model = [AreaModel mj_objectWithKeyValues:dict];
        if ([model.name isEqualToString:@"广东省"]) {
            NSMutableArray *tempArray = [NSMutableArray array];
            for (AreaModel *cityModel in model.city) {
                if ([cityModel.name isEqualToString:@"广州市"] || [cityModel.name isEqualToString:@"佛山市"]) {
                    [tempArray addObject:cityModel];
                }
            }
            model.city = tempArray;
            [self.provinceArr addObject:model];
            break;
        }
    }
    
    [self.cityArr addObjectsFromArray:((AreaModel *)self.provinceArr.firstObject).city];
    [self.areaArr addObjectsFromArray:((AreaModel *)self.cityArr.firstObject).area];
    
    [self.pickerView reloadAllComponents];
    
    [self setTitleLabelStr];
}

- (void)loadSelectProvinceCityAreaAll {
    for (NSDictionary *dict in [Tools getSelectProvinceCityAreaAll]) {
        NSDictionary *tempDict = @{
            @"name":dict[@"CityName"],
            @"code":dict[@"CityID"],
            @"city":dict[@"children"],
        };
        AreaModel *model = [AreaModel mj_objectWithKeyValues:tempDict];
        if ([model.name isEqualToString:@"广东省"]) {
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *cityDict in dict[@"children"]) {
                if ([cityDict[@"CityName"] isEqualToString:@"广州市"] || [cityDict[@"CityName"] isEqualToString:@"佛山市"]) {
                    NSDictionary *tempCityDict = @{
                        @"name":cityDict[@"CityName"],
                        @"code":cityDict[@"CityID"],
                        @"city":cityDict[@"children"],
                    };
                    [tempArray addObject:tempCityDict];
                }
            }
            model.city = tempArray;
            [self.provinceArr addObject:model];
            break;
        }
    }
    
    [self.cityArr addObjectsFromArray:((AreaModel *)self.provinceArr.firstObject).city];
    [self.areaArr addObjectsFromArray:((AreaModel *)self.cityArr.firstObject).area];
    
    [self.pickerView reloadAllComponents];
    
    [self setTitleLabelStr];
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
        if (self.didSelectHouseBlock) {
            AreaModel *model = self.provinceArr[self.provinceIndex];
            self.didSelectHouseBlock(model.name, model.code);
        }
        if (self.didSelectItemBlock){
            AreaModel *model = self.cityArr[self.cityIndex];
            self.didSelectItemBlock(model.name, model.code);
        }
        
        if (self.didSelectAreaBlock) {
            self.didSelectAreaBlock(self.titleLabel.text);
        }
        
        if (self.didSelectCityAndAreaBlock) {
            AreaModel *cityModel = self.cityArr[self.cityIndex];
            AreaModel *areaModel = self.areaArr[self.areaIndex];
            self.didSelectCityAndAreaBlock(cityModel.name, cityModel.code, areaModel.name, areaModel.code);
        }
        
        if (self.didSelectProvinceCityAreaAllBlock) {
            AreaModel *model = self.cityArr[self.cityIndex];
            self.didSelectProvinceCityAreaAllBlock(model.name, model.code);
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
    AreaModel *model = arr[component][row];
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
    
    NSArray *cityArray = ((AreaModel *)self.provinceArr[row]).city;
    if (cityArray.count){
        [self.cityArr removeAllObjects];
        [self.cityArr addObjectsFromArray:cityArray];
        
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        
        NSArray *areaArray = ((AreaModel *)self.cityArr.firstObject).area;
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
        NSArray *areaArray = ((AreaModel *)self.cityArr[row]).area;
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
        provStr = ((AreaModel *)self.provinceArr[self.provinceIndex]).name;
    }
    
    if (self.cityArr.count) {
         cityStr = ((AreaModel *)self.cityArr[self.cityIndex]).name;
    }
    if (self.areaArr.count) {
        areaStr = ((AreaModel *)self.areaArr[self.areaIndex]).name;
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
