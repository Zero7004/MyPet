//
//  MSTBaseModel.h
//  Jiehuo
//
//  Created by 王健龙 on 16/3/16.
//  Copyright © 2016年 王健龙. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MCBaseModel : JSONModel

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *code;

- (BOOL)isSuccess;

@end
