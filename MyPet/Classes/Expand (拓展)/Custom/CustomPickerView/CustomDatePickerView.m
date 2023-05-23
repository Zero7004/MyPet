//
//  CustomDatePickerView.m
//  MyPet
//
//  Created by long on 2021/9/8.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "CustomDatePickerView.h"

#define PickHeight (230)

@interface CustomDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *grayBtn;
@property (nonatomic, strong) UIPickerView *pickerView;

//时间可是为“2018-06-13 19:30”形式。
@property(nonatomic, strong)NSString *starTime;//开始时间
@property(nonatomic, strong)NSString *endTime;//结束时间

@property (nonatomic, strong)NSMutableArray *yearArray;

@property (nonatomic, strong)NSMutableArray *monthArray;
@property (nonatomic, strong)NSMutableArray *monthMutableArray;
@property (nonatomic,strong)NSMutableArray *endMonthArr;

@property (nonatomic, strong)NSMutableArray *dayArray;
@property (nonatomic, strong)NSMutableArray *dayMutableArray;
@property (nonatomic, strong)NSMutableArray *endDayArr;

@property (nonatomic, strong)NSMutableArray *hourArray;
@property (nonatomic, strong)NSMutableArray *hourMutableArray;
@property (nonatomic, strong)NSMutableArray *endHourArr;

@property(nonatomic, strong)NSMutableArray *pointArray;
@property(nonatomic, strong)NSMutableArray *pointMutableArray;
@property(nonatomic, strong)NSMutableArray *endPointArr;

@end

@implementation CustomDatePickerView {
    int year;
    int endYear;
    int month;
    int endMonth;
    int day;
    int endDay;
    int hour;
    int endHour;
    int point;
    int endPoint;
    
    NSString *currentMonthString;
//    NSInteger m;
    NSInteger selectedYearRow;
}

- (instancetype)initWithStarTime:(NSString *)starTime EndTime:(NSString *)endTime {
    if (self = [super init]) {
        self.starTime = starTime;
        self.endTime = endTime;
        [self creatView];
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
    
    [self addTime];

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

- (void)setPickerType:(DatePickerType)pickerType {
    _pickerType = pickerType;
    [self.pickerView reloadAllComponents];
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

- (void)topButtonAction:(UIButton *)sender {
    if (sender.tag == 101) {
        NSString *time;
        int component0 = (int)[self.pickerView selectedRowInComponent:0];
        int component1 = (int)[self.pickerView selectedRowInComponent:1];
        int component2 = (int)[self.pickerView selectedRowInComponent:2];
        int component3 = 0;
//        int component4 = 0;

        if (self.pickerType == DatePickerType_default) {
            component3 = (int)[self.pickerView selectedRowInComponent:3];
//            component4 = (int)[self.pickerView selectedRowInComponent:4];
        }
        
        int selectedMon;
        NSMutableArray *selectedMonArr;
        if (component0 == 0&&component0 != self.yearArray.count-1) {
            selectedMon = [self.monthMutableArray[component1]intValue];
            selectedMonArr = [self.monthMutableArray mutableCopy];
        }else if(component0 == self.yearArray.count-1){
            selectedMon = [self.endMonthArr[component1] intValue];
            selectedMonArr = [self.endMonthArr mutableCopy];
        }else{
            selectedMon = [self.monthArray[component1]intValue];
            selectedMonArr = [self.monthArray mutableCopy];
        }
        //年
        time = [NSString stringWithFormat:@"%@",self.yearArray[component0]];
        //月
        if (component0 == 0&& component0 != self.yearArray.count-1) {
            time =  [NSString stringWithFormat:@"%@-%@",time,self.monthMutableArray[component1]];
        }else if(component0 == self.yearArray.count-1){
            time =  [NSString stringWithFormat:@"%@-%@",time,self.endMonthArr[component1]];
        }else
        {
            time =  [NSString stringWithFormat:@"%@-%@",time,self.monthArray[component1]];;
        }
        //日
        if (component0==0 &component1==0&&!(component0 == self.yearArray.count-1 &component1==selectedMonArr.count-1)) {
            time =  [NSString stringWithFormat:@"%@-%@",time,self.dayMutableArray[component2]];
            
        }else if(component0 == self.yearArray.count-1 &component1==selectedMonArr.count-1){
            time =  [NSString stringWithFormat:@"%@-%@",time,self.endDayArr[component2]];
        }else{
            time =  [NSString stringWithFormat:@"%@-%@",time,self.dayArray[component2]];
        }
        //小时
        if (component0==0 &component1==0&&component2==0&&!(component0 == self.yearArray.count - 1 &&component1==self.endMonthArr.count-1  &&component2==self.endDayArr.count-1)) {
            time =  [NSString stringWithFormat:@"%@ %@",time,self.hourMutableArray[component3]];
        }else if(component0 == self.yearArray.count - 1 &&component1==self.endMonthArr.count-1  &&component2==self.endDayArr.count-1){
            time =  [NSString stringWithFormat:@"%@ %@",time,self.endHourArr[component3]];
        }else{
            time =  [NSString stringWithFormat:@"%@ %@",time,self.hourArray[component3]];
        }
        //分
//        if (component0==0 &component1==0&&component2==0&&component3==0&&!(component0 == self.yearArray.count - 1 &&component1==self.endMonthArr.count-1  &&component2==self.endDayArr.count-1 && component3 == self.endHourArr.count - 1)) {
//            time =  [NSString stringWithFormat:@"%@:%@",time,self.pointMutableArray[component4]];
//        }else if(component0 == self.yearArray.count - 1 &&component1==self.endMonthArr.count-1  &&component2==self.endDayArr.count-1 && component3 == self.endHourArr.count - 1){
//            time =  [NSString stringWithFormat:@"%@:%@",time,self.endPointArr[component4]];
//        }else{
//            time =  [NSString stringWithFormat:@"%@:%@",time,self.pointArray[component4]];
//        }
        
        if(self.timeBlock){
           self.timeBlock(time);
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

- (void)addTime{
    
    //NSDate *date = [NSDate date];
    
    NSDateFormatter *formatterS = [[NSDateFormatter alloc]init];
    
    [formatterS setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     NSDate *starDate = [formatterS dateFromString:self.starTime];
     NSDate *endDate = [formatterS dateFromString:self.endTime];
    
    NSComparisonResult result = [starDate compare:endDate];
   
    if (result == NSOrderedDescending) {
        NSLog(@"传入的时间  结束时间应 大于开始时间");
        return ;
    }
    
    // Get Current Year
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    
    NSString *currentyearString = [NSString stringWithFormat:@"%@",
                                   [formatter stringFromDate:starDate]];
    year =[currentyearString intValue];
    NSString *endyearString = [NSString stringWithFormat:@"%@",
                               [formatter stringFromDate:endDate]];
    endYear = [endyearString intValue];
    
    
    // Get Current  Month
    
    [formatter setDateFormat:@"MM"];
    
    currentMonthString = [NSString stringWithFormat:@"%ld",(long)[[formatter stringFromDate:starDate]integerValue]];
    month=[currentMonthString intValue];
    
    NSString *endMonthString =[NSString stringWithFormat:@"%ld",(long)[[formatter stringFromDate:endDate]integerValue]];
    endMonth = [endMonthString intValue];
    
    // Get Current  Date
    
    [formatter setDateFormat:@"dd"];
    NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:starDate]];
    day =[currentDateString intValue];
    NSString *endDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:endDate]];
    endDay =[endDateString intValue];
    
    
    [formatter setDateFormat:@"HH"];
    NSString *currentHourString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:starDate]];
    hour = [currentHourString intValue];
    NSString *endHourString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:endDate]];
    endHour = [endHourString intValue];
    
    
    [formatter setDateFormat:@"mm"];
    NSString *currentPointString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:starDate]];
    point = [currentPointString intValue];
    NSString *endPointString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:endDate]];
    endPoint = [endPointString intValue];
    
    
    self.yearArray = [NSMutableArray array];
    
    self.monthArray = [NSMutableArray array];
    self.monthMutableArray = [NSMutableArray array];
    self.endMonthArr = [NSMutableArray array];
    
    self.dayMutableArray = [NSMutableArray array];
    self.dayArray = [NSMutableArray array];
    self.endDayArr = [NSMutableArray array];
    
    self.hourArray = [NSMutableArray array];
    self.hourMutableArray = [NSMutableArray array];
    self.endHourArr = [NSMutableArray array];
    
    self.pointArray = [NSMutableArray array];
    self.pointMutableArray = [NSMutableArray array];
    self.endPointArr = [NSMutableArray array];
    //年
    for (int i = 0; i <= endYear-year; i ++) {
        NSString *yearString = [NSString stringWithFormat:@"%d",year + i];
        [self.yearArray addObject:yearString];
    }
    
    //月份
    if(endYear == year){
        for(int t=month;t<=endMonth;t++){
            NSString *endyearmonth = [NSString string];
            if (t < 10) {
                endyearmonth = [NSString stringWithFormat:@"0%d",t];
            }else{
                endyearmonth = [NSString stringWithFormat:@"%d",t];
            }
            [self.endMonthArr addObject:endyearmonth];
        }
    }else{
        for (int j= month; j <= 12; j ++) {
            NSString *yearmonth = [NSString string];
            if (j < 10) {
                yearmonth = [NSString stringWithFormat:@"0%d",j];
            }else{
                yearmonth = [NSString stringWithFormat:@"%d",j];
            }
            
            [self.monthMutableArray addObject:yearmonth];
        }
        for(int t=1;t<=endMonth;t++){
            NSString *endyearmonth = [NSString string];
            if (t < 10) {
                endyearmonth = [NSString stringWithFormat:@"0%d",t];
            }else{
                endyearmonth = [NSString stringWithFormat:@"%d",t];
            }
            [self.endMonthArr addObject:endyearmonth];
        }
        
        for(int j= 1; j <= 12; j ++) {
            NSString *yearmonth = [NSString string];
            if (j < 10) {
                yearmonth = [NSString stringWithFormat:@"0%d",j];
            }else{
                yearmonth = [NSString stringWithFormat:@"%d",j];
            }
            [self.monthArray addObject:yearmonth];
        }
    }
    //天
    if(endYear == year && month == endMonth){
        for(int t = day;t<=endDay;t++){
            NSString *enddayString = [NSString string];
            if (t < 10) {
                enddayString = [NSString stringWithFormat:@"0%d",t];
            }else{
                enddayString = [NSString stringWithFormat:@"%d",t];
            }
            [self.endDayArr addObject:enddayString];
        }
    }else{
        for (int i = 1; i <= 31; i++)
        {   NSString *dayString = [NSString string];
            if (i < 10) {
                dayString = [NSString stringWithFormat:@"0%d",i];
            }else{
                dayString = [NSString stringWithFormat:@"%d",i];
            }
            [self.dayArray addObject:dayString];
            
        }
        for (int i = day; i <=31; i++)
        {
            NSString *dayString = [NSString string];
            if (i < 10) {
                dayString = [NSString stringWithFormat:@"0%d",i];
            }else{
                dayString = [NSString stringWithFormat:@"%d",i];
            }
            
            [self.dayMutableArray addObject:dayString];
        }
        for(int t = 1;t<=endDay;t++){
            NSString *enddayString = [NSString string];
            if (t < 10) {
                enddayString = [NSString stringWithFormat:@"0%d",t];
            }else{
                enddayString = [NSString stringWithFormat:@"%d",t];
            }
            [self.endDayArr addObject:enddayString];
        }
    }
    
    //小时
    if(endYear == year && month == endMonth && day == endDay){
        for(int t = hour;t<=endHour;t++){
            NSString *endhourString = [NSString string];
            if (t < 10) {
                endhourString = [NSString stringWithFormat:@"0%d",t];
            }else{
                endhourString = [NSString stringWithFormat:@"%d",t];
            }
            
            [self.endHourArr addObject:endhourString];
        }
    }else{
        for (int i = 0; i <= 23; i++)
        {   NSString *hourString = [NSString string];
            if (i < 10) {
                hourString = [NSString stringWithFormat:@"0%d",i];
            }else{
                hourString = [NSString stringWithFormat:@"%d",i];
            }
            [self.hourArray addObject:hourString];
            
        }
        for (int i = hour; i <=23; i++)
        {
            NSString *hourString = [NSString string];
            if (i < 10) {
                hourString = [NSString stringWithFormat:@"0%d",i];
            }else{
                hourString = [NSString stringWithFormat:@"%d",i];
            }
            
            [self.hourMutableArray addObject:hourString];
        }
        for(int t = 0;t<=endHour;t++){
            NSString *endhourString = [NSString string];
            if (t < 10) {
                endhourString = [NSString stringWithFormat:@"0%d",t];
            }else{
                endhourString = [NSString stringWithFormat:@"%d",t];
            }
            
            [self.endHourArr addObject:endhourString];
        }
    }
    
    //分钟
    if(endYear == year && month == endMonth && day == endDay){
        for (int i = point; i <=endPoint; i++)
        {
            NSString *pointString = [NSString string];
            if (i < 10) {
                pointString = [NSString stringWithFormat:@"0%d",i];
            }else{
                pointString = [NSString stringWithFormat:@"%d",i];
            }
            
            [self.endPointArr addObject:pointString];
        }
    }else{
        for (int i = 0; i <= 59; i++)
        {   NSString *pointString = [NSString string];
            if (i < 10) {
                pointString = [NSString stringWithFormat:@"0%d",i];
            }else{
                pointString = [NSString stringWithFormat:@"%d",i];
            }
            [self.pointArray addObject:pointString];
            
        }
        for (int i = point; i <=59; i++)
        {
            NSString *pointString = [NSString string];
            if (i < 10) {
                pointString = [NSString stringWithFormat:@"0%d",i];
            }else{
                pointString = [NSString stringWithFormat:@"%d",i];
            }
            
            [self.pointMutableArray addObject:pointString];
        }
        for (int i = 0; i <=endPoint; i++)
        {
            NSString *pointString = [NSString string];
            if (i < 10) {
                pointString = [NSString stringWithFormat:@"0%d",i];
            }else{
                pointString = [NSString stringWithFormat:@"%d",i];
            }
            
            [self.endPointArr addObject:pointString];
        }
    }
}

#pragma mark ------------ pickViewDelegate ------------

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    m=row;
    
    if (component == 0)
    {
        selectedYearRow = row;
        [self.pickerView reloadAllComponents];
    }
    else if (component == 1)
    {
//        selectedMonthRow = row;
        [self.pickerView reloadAllComponents];
    }
    else if (component == 2)
    {
//        selectedDayRow = row;
        [self.pickerView reloadAllComponents];
        
    }else if(component == 3){
//        selectedHourRow = row;
        [self.pickerView reloadAllComponents];
    }
    
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.pickerType == DatePickerType_ymd) {
        return 3;
    }
    return 4;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {//年
        return self.yearArray.count;
    }
    if (component == 1) {//月
        NSInteger selectRow =  [pickerView selectedRowInComponent:0];
        
        if (selectRow == 0&&selectRow != self.yearArray.count-1) {
            return [self.monthMutableArray count];
        }else if(selectRow == self.yearArray.count-1){
            return [self.endMonthArr count];
        }else
        {
            return [self.monthArray count];
        }
    }
    if (component == 2) {//天
        
        NSInteger selectRow =  [pickerView selectedRowInComponent:0];
        NSInteger selectRow1 = [pickerView selectedRowInComponent:1];;
        int selectedMon;
        NSMutableArray *selectedMonArr;
        if (selectRow == 0 && selectRow != self.yearArray.count-1 ) {
            selectedMon = [self.monthMutableArray[selectRow1]intValue];
            selectedMonArr = [self.monthMutableArray mutableCopy];
        }else if(selectRow == self.yearArray.count-1){
            selectedMon = [self.endMonthArr[selectRow1] intValue];
            selectedMonArr = [self.endMonthArr mutableCopy];
        }else{
            selectedMon = [self.monthArray[selectRow1]intValue];
             selectedMonArr = [self.monthArray mutableCopy];
        }
        if (selectRow == 0 && selectRow != self.yearArray.count-1 && selectRow1 == 0) {
            //全选第一个row
            if (selectedMon == 1 || selectedMon == 3 || selectedMon == 5 || selectedMon == 7 || selectedMon == 8 || selectedMon == 10 || selectedMon == 12)
            {
                return self.dayMutableArray.count;
            }else if (selectedMon == 2)
            {
                int yearint = [[self.yearArray objectAtIndex:selectedYearRow]intValue];

                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    return self.dayMutableArray.count-2;
                }
                else
                {
                    return self.dayMutableArray.count-3; // or return 29
                }
            }
            else
            {
                return self.dayMutableArray.count-1;
            }
        }else if(selectRow == self.yearArray.count-1 && selectRow1==selectedMonArr.count-1){
                return self.endDayArr.count;
        }else{
            //不是最后一个row  也 不是第一个row
            if (selectRow == 0 && selectRow1 == 0) {
                return self.dayMutableArray.count;
            }
            
            if (selectedMon == 1 || selectedMon == 3 || selectedMon == 5 || selectedMon == 7 || selectedMon == 8 || selectedMon == 10 || selectedMon == 12)
            {
                return 31;
            }
            else if (selectedMon == 2)
            {
                int yearint = [[self.yearArray objectAtIndex:selectedYearRow]intValue];

                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    return 29;
                }
                else
                {
                    return 28; // or return 29
                }
            }
            else
            {
                return 30;
            }
        }
        
    }
    if (component == 3) {//小时
        NSInteger selectRow =  [pickerView selectedRowInComponent:0];
        NSInteger selectRow1 =  [pickerView selectedRowInComponent:1];
        NSInteger selectRow2 =  [pickerView selectedRowInComponent:2];
        if (selectRow == 0 &&selectRow1==0  &&selectRow2==0&&!(selectRow == self.yearArray.count - 1&&selectRow1==self.endMonthArr.count-1&&selectRow2==self.endDayArr.count-1)) {
            return self.hourMutableArray.count;
        }else if(selectRow == self.yearArray.count - 1 &&selectRow1==self.endMonthArr.count-1  &&selectRow2==self.endDayArr.count-1){
            return self.endHourArr.count;
        }else{
            return self.hourArray.count;
        }
    }
    if (component == 4) {//分钟
        NSInteger selectRow =  [pickerView selectedRowInComponent:0];
        NSInteger selectRow1 =  [pickerView selectedRowInComponent:1];
        NSInteger selectRow2 =  [pickerView selectedRowInComponent:2];
        NSInteger selectRow3 =  [pickerView selectedRowInComponent:3];
        if (selectRow == 0 &&selectRow1==0  &&selectRow2==0 && selectRow3 == 0&&!(selectRow == self.yearArray.count - 1 &&selectRow1==self.endMonthArr.count-1  &&selectRow2==self.endDayArr.count-1 && selectRow3 == self.endHourArr.count - 1)) {
            return self.pointMutableArray.count;
        }else if(selectRow == self.yearArray.count - 1 &&selectRow1==self.endMonthArr.count-1  &&selectRow2==self.endDayArr.count-1 && selectRow3 == self.endHourArr.count - 1){
            return self.endPointArr.count;
        }else{
            return self.pointArray.count;
        }
    }
    return 0;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *pickerLabel = (UILabel *)view;
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, 60, 50);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:16]];
        
    }
    
    if (component == 0)
    {
        pickerLabel.text =  [NSString stringWithFormat:@"%@%@",self.yearArray[row] ,@"年"]; // Year
    }
    if (component == 1)
    {
        NSInteger selectRow =  [pickerView selectedRowInComponent:0];
        if (selectRow == 0 && selectRow != self.yearArray.count-1) {
            pickerLabel.text =  [NSString stringWithFormat:@"%@%@",self.monthMutableArray[row] ,@"月"];
            
        }else if(selectRow == self.yearArray.count-1){
             pickerLabel.text =  [NSString stringWithFormat:@"%@%@",self.endMonthArr[row] ,@"月"];
        }else
        {
            pickerLabel.text =  [NSString stringWithFormat:@"%@%@",self.monthArray[row] ,@"月"];
            
        }
    }
    if (component == 2)
    {
        NSInteger selectRow =  [pickerView selectedRowInComponent:0];
        
        NSInteger selectRow1 = [pickerView selectedRowInComponent:1];
        int selectedMon;
        NSMutableArray *selectedMonArr;
        if (selectRow == 0&&selectRow != self.yearArray.count-1) {
            selectedMon = [self.monthMutableArray[selectRow1]intValue];
            selectedMonArr = [self.monthMutableArray mutableCopy];
        }else if(selectRow == self.yearArray.count-1){
            selectedMon = [self.endMonthArr[selectRow1] intValue];
            selectedMonArr = [self.endMonthArr mutableCopy];
        }else{
            selectedMon = [self.monthArray[selectRow1]intValue];
            selectedMonArr = [self.monthArray mutableCopy];
        }
        
        if (selectRow==0 &selectRow1==0&&!(selectRow == self.yearArray.count-1 &selectRow1==selectedMonArr.count-1)) {
            pickerLabel.text =  [NSString stringWithFormat:@"%@%@",self.dayMutableArray[row] ,@"日"];
            
        }else if(selectRow == self.yearArray.count-1 &selectRow1==selectedMonArr.count-1){
            //全选最后一个row
            pickerLabel.text =  [NSString stringWithFormat:@"%@%@",self.endDayArr[row] ,@"日"];
        }else{
            pickerLabel.text =  [NSString stringWithFormat:@"%@%@",self.dayArray[row] ,@"日"];
            
        }
    }
    if (component == 3) {
        NSInteger selectRow =  [pickerView selectedRowInComponent:0];
        NSInteger selectRow1 =  [pickerView selectedRowInComponent:1];
        NSInteger selectRow2 =  [pickerView selectedRowInComponent:2];
        if (selectRow == 0 &&selectRow1==0  &&selectRow2==0&&!(selectRow == self.yearArray.count - 1 &&selectRow1==self.endMonthArr.count-1  &&selectRow2==self.endDayArr.count-1)) {
            pickerLabel.text =[NSString stringWithFormat:@"%@时",self.hourMutableArray[row]];
        }else if(selectRow == self.yearArray.count - 1 &&selectRow1==self.endMonthArr.count-1  &&selectRow2==self.endDayArr.count-1){
             pickerLabel.text =[NSString stringWithFormat:@"%@时",self.endHourArr[row]];
        }else{
            pickerLabel.text =[NSString stringWithFormat:@"%@时",self.hourArray[row]];
        }
    }
    if (component == 4) {
        NSInteger selectRow =  [pickerView selectedRowInComponent:0];
        NSInteger selectRow1 =  [pickerView selectedRowInComponent:1];
        NSInteger selectRow2 =  [pickerView selectedRowInComponent:2];
        NSInteger selectRow3 =  [pickerView selectedRowInComponent:3];
        
        if (selectRow == 0 &&selectRow1==0  &&selectRow2==0 && selectRow3 == 0&&!(selectRow == self.yearArray.count - 1 &&selectRow1==self.endMonthArr.count-1  &&selectRow2==self.endDayArr.count-1 && selectRow3 == self.endHourArr.count - 1)) {
            pickerLabel.text =[NSString stringWithFormat:@"%@分", self.pointMutableArray[row]];
        }else if(selectRow == self.yearArray.count - 1 &&selectRow1==self.endMonthArr.count-1  &&selectRow2==self.endDayArr.count-1 && selectRow3 == self.endHourArr.count - 1){
            pickerLabel.text = [NSString stringWithFormat:@"%@分",self.endPointArr[row]];
        }else{
            pickerLabel.text = [NSString stringWithFormat:@"%@分",self.pointArray[row]];
        }
    }
    return pickerLabel;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35;
}


@end
