//
//  SubBaseModel.m
//  XinYiYiLiao
//
//  Created by 王健龙 on 16/9/2.
//  Copyright © 2016年 王健龙. All rights reserved.
//

#import "MCSubBaseModel.h"

@implementation MCSubBaseModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

-(id)valueForUndefinedKey:(NSString *)key{
    NSLog(@"出现异常，该key: %@ 不存在",key);
    return nil;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"出现异常，该key: %@ 不存在",key);
}

-(void)setNilValueForKey:(NSString *)key{
    NSLog(@"不能将 %@ 设成nil",key);
}

@end
