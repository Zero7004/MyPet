//
//  MSTBaseModel.m
//  Jiehuo
//
//  Created by 王健龙 on 16/3/16.
//  Copyright © 2016年 王健龙. All rights reserved.
//

#import "MCBaseModel.h"

@implementation MCBaseModel

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

- (BOOL)isSuccess{
    return [self.code isEqualToString:@"0"];
}
@end
