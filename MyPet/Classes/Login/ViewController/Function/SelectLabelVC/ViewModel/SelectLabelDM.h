//
//  SelectLabelDM.h
//  MyPet
//
//  Created by long on 2022/7/21.
//  Copyright © 2022 王健龙. All rights reserved.
//

#import "MCBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SelectLabelType) {
    SelectLabelType_default,   /// 默认单选
    SelectLabelType_multiple,  /// 多选
};

@protocol SelectLabelItmeDM;
@interface SelectLabelDM : MCBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) SelectLabelType selectType;
@property (nonatomic, copy) NSArray <SelectLabelItmeDM>*itmes;

@end

@interface SelectLabelItmeDM : MCSubBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, copy) NSString *value;

@end

@interface SelectLabeTitleDM : MCBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;

@end



NS_ASSUME_NONNULL_END
