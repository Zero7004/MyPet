//
//  AreaModel.m
//  MyPet
//
//  Created by 王健龙 on 2019/6/27.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "AreaModel.h"

@implementation AreaModel

- (void)setCity:(NSArray *)city {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (NSDictionary *dict in city) {
        AreaModel *model = [AreaModel mj_objectWithKeyValues:dict];
        [mutArr addObject:model];
    }
    _city = mutArr;
}

- (void)setArea:(NSArray *)area {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (NSDictionary *dict in area) {
        AreaModel *model = [AreaModel mj_objectWithKeyValues:dict];
        [mutArr addObject:model];
    }
    _area = mutArr;
}


@end

@implementation RegionDataModel

@end

@implementation RegionChildrenDataModel

@end

