//
//  MPUserDefaultManager.h
//  MyPet
//
//  Created by long on 2023/5/23.
//  Copyright © 2023 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPUserDefaultManagerKeyValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPUserDefaultManager : NSObject

+ (void)setValue:(NSObject *)value forKey:(NSString *)key;

+ (void)setBoolValue:(BOOL)value forKey:(NSString *)key;

+ (void)setIntegerValue:(NSInteger)value forKey:(NSString *)key;

+ (id)getValueForKey:(NSString *)key;

+ (BOOL)getBoolValueForKey:(NSString *)key;

+ (NSInteger)getIntegerValueForKey:(NSString *)key;

+ (void)removeValueForKey:(NSString *)key;

+ (void)setLangWithValue:(NSString *)value;

+ (NSString *)getLang;

@end

NS_ASSUME_NONNULL_END
