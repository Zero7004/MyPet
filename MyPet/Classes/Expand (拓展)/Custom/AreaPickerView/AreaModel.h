//
//  AreaModel.h
//  MyPet
//
//  Created by 王健龙 on 2019/6/27.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCBaseModel.h"
#import "MCSubBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AreaModel : NSObject

/// 省级code
@property (strong ,nonatomic) NSString *code;
/// 省级名称
@property (strong ,nonatomic) NSString *name;
/// 城市列表
@property (strong ,nonatomic) NSArray *city;
/// 区列表
@property (strong ,nonatomic) NSArray *area;
/// 所属省级code
@property (strong ,nonatomic) NSString *provinceCode;
@end

@protocol RegionChildrenDataModel;
@interface RegionDataModel: MCBaseModel
@property (nonatomic, strong) NSArray<RegionChildrenDataModel> *data;
@property (nonatomic, assign) BOOL success;
@end

@interface RegionChildrenDataModel: MCSubBaseModel
@property (nonatomic, strong) NSArray<RegionChildrenDataModel> *children;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pid;
@end


NS_ASSUME_NONNULL_END
