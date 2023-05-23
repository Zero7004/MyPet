//
//  LabelView.m
//  Loans_Users
//
//  Created by 王健龙 on 2019/5/29.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "LabelView.h"

#import "SearchKeyModel.h"
#import "UIColor+hexColor.h"

@interface LabelView ()
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LabelView

//- (instancetype)initWithFrame:(CGRect)frame type:(labelType)type labelArray:(NSArray *)labelArray {
//    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor whiteColor];
//        [self setUpTopView:type];
//
//        [self setUpLabel:labelArray];
//    }
//    return self;
//}


- (instancetype)initWithType:(labelType)type labelArray:(NSArray *)labelArray {
    self = [super init];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        [self setUpTopView:type];
        [self setUpLabel:labelArray];
    }
    return self;

}

- (void)setUpTopView:(labelType)type {
    
    //标签标题
    UILabel *label = [[UILabel alloc] init];
    label.text = type == 0 ? @"热门搜索" : @"最近搜索";
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15.0f];
    label.textColor = [UIColor colorWithHexString:@"#1F2733"];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@21);
        make.left.equalTo(@16);
    }];
    self.titleLabel = label;
    
    //图标
    UIImageView *imageView = [[UIImageView alloc] init];
    if (type == 0) {
        [self addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"home_label_hot"];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.mas_right).offset(2.5);
            make.centerY.equalTo(label.mas_centerY).offset(0);
            make.width.equalTo(@11);
            make.height.equalTo(@14);
        }];
    }
        
    if (type == 1) {
        UIButton *delectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [delectButton setImage:[UIImage imageNamed:@"home_search_delect"] forState:UIControlStateNormal];
        [[delectButton rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(__kindof UIControl * _Nullable x) {
            //删除历史记录
            [self deleteHistoryLabel];
            UIView *delectView = [self viewWithTag:211];
            [delectView removeFromSuperview];
        }];
        [self addSubview:delectButton];
        [delectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@35);
            make.centerY.equalTo(label.mas_centerY).offset(0);
            make.right.equalTo(@-10);
        }];
    }
}


- (void)setUpLabel:(NSArray *)labelArray{
    
    NSMutableArray *buttonArray = [NSMutableArray new];
    for (int i = 0; i < labelArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:14.0f];
        [btn setTitleColor:[UIColor colorWithHexString:@"#1F2733"] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        SearchKeyModel *model = labelArray[i];
        [btn setTitle:model.keyword forState:UIControlStateNormal];
        [self addSubview:btn];
        
        NSInteger index = i / 2;
        if ((i + 1) % 2 == 0) {
            //右边
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_centerX).offset(16);
                make.right.equalTo(self).offset(-16);
                make.height.offset(18);
                make.top.equalTo(self.titleLabel.mas_bottom).offset(10 + (index * 26));
                if (i == labelArray.count - 1) {
                    make.bottom.equalTo(@0);
                }
            }];
        } else {
            //左边
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(16);
                make.right.equalTo(self.mas_centerX).offset(-16);
                make.height.offset(18);
                make.top.equalTo(self.titleLabel.mas_bottom).offset(10 + (index * 26));
                if (i == labelArray.count - 1) {
                    make.bottom.equalTo(@0);
                }
            }];
        }
        
        [[btn rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.selectLabelBlock) {
                self.selectLabelBlock(model);
            }
        }];
        [buttonArray addObject:btn];
    }
    
}

//删除历史记录
- (void)deleteHistoryLabel {
    NSFileManager *fileManage = [NSFileManager defaultManager];
    
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"historyLabel.plist"];
    if ([fileManage fileExistsAtPath:filePatch]) {
         BOOL isBool = [fileManage removeItemAtPath:filePatch error:nil];
        if (isBool && self.delectHistoryLabelBlock) {
            self.delectHistoryLabelBlock();
        }
    }
    
}

@end
