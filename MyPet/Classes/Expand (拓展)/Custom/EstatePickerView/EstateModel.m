//
//  EstateModel.m
//  MyPet
//
//  Created by 王健龙 on 2019/7/18.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "EstateModel.h"

@implementation EstateModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"estateId":@"id",
             };
}
@end
