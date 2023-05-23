//
//  SelectLabelVM.m
//  MyPet
//
//  Created by long on 2022/7/21.
//  Copyright © 2022 王健龙. All rights reserved.
//

#import "SelectLabelVM.h"

@interface SelectLabelVM ()

@end

@implementation SelectLabelVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData {
    NSArray *titles = @[@"您的就职机构（单选）", @"您的主要获客方式（可多选）", @"您的从事金融行业时间", @"您的从业范围（可多选）"];
    NSArray *subTitle = @[@"", @"", @"", @"贷款", @"保险", @"基金", @"信用卡"];
    
    NSArray *item_01 = @[@"银行机构", @"企业服务/财税公司", @"理财工作室", @"贷款公司", @"保险代理公司", @"保险经纪公司", @"保险公司", @"自雇人士"];
    NSArray *item_02 = @[@"收单", @"电销", @"地推", @"转介绍", @"互联网推广（自媒体IP）",];
    NSArray *item_03 = @[@"1年以下", @"1～3年", @"3～5年", @"5～10年", @"10年以上"];
    NSArray *item_04 = @[@"税金贷", @"发票贷", @"个类贷", @"烟草贷", @"商户贷", @"票据", @"供应链", @"公积金", @"经营性贷款", @"车辆抵押贷", @"不动产抵押贷"];
    NSArray *item_05 = @[@"意外险", @"医疗险", @"重疾险", @"定期寿险", @"终身寿险", @"财产险", @"团体险", @"车险", @"子女教育金", @"养老年金险", @"其他"];
    NSArray *item_06 = @[@"公募基金", @"私募基金"];
    NSArray *item_07 = @[@"信用卡"];
    
    NSArray *itemArray = @[item_01, item_02, item_03, item_04, item_05, item_06, item_07];
    
    //配置大标题数据
    [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        SelectLabeTitleDM *model = [SelectLabeTitleDM new];
        model.title = title;
        if (idx == 3) {
            model.subTitle = @"根据您的选择，为您精准匹配产品";
        }
        [self.titleArray addObject:model];
    }];
    
    //配置标签数据
    [itemArray enumerateObjectsUsingBlock:^(NSArray *array, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *items = [NSMutableArray new];
        SelectLabelDM *itmeModel = [SelectLabelDM new];
        itmeModel.title = subTitle[idx];
        if (idx == 0 || idx == 2) {
            itmeModel.selectType = SelectLabelType_default;
        } else {
            itmeModel.selectType = SelectLabelType_multiple;
        }
        [array enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idy, BOOL * _Nonnull stop) {
            SelectLabelItmeDM *model = SelectLabelItmeDM.new;
            model.title = title;
            [items addObject:model];
        }];
        itmeModel.itmes = [items copy];
        [self.dataArray addObject:itmeModel];
    }];
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray new];
    }
    return _titleArray;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

@end
