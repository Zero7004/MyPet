//
//  MPUserDefaultManager.m
//  MyPet
//
//  Created by long on 2023/5/23.
//  Copyright © 2023 王健龙. All rights reserved.
//

#import "MPUserDefaultManager.h"

@implementation MPUserDefaultManager

+ (void)setValue:(NSObject *)value forKey:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setIntegerValue:(NSInteger)value forKey:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setBoolValue:(BOOL)value forKey:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getValueForKey:(NSString *)key{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (BOOL)getBoolValueForKey:(NSString *)key{
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+ (NSInteger)getIntegerValueForKey:(NSString *)key{
    
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+ (void)removeValueForKey:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
