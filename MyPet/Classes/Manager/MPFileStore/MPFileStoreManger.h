//
//  MPFileStoreManger.h
//  MyPet
//
//  Created by long on 2023/5/23.
//  Copyright © 2023 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPFileStoreManger : NSObject

# pragma mark - json file add select delete

+ (void)saveJsonFileWithName:(NSString *)fileName jsonDic:(NSDictionary *)jsonDic;

+ (void)removeJsonFileWithName:(NSString *)fileName;

+ (NSDictionary *)getJsonFileWithName:(NSString *)fileName;

+ (void)saveStaticJsonFileName:(NSString *)fileName jsonDic:(NSDictionary *)jsonDic;

+ (void)removeStaticJsonFileWithName:(NSString *)fileName;

+ (NSDictionary *)getStaticJsonFileWithJsonName:(NSString *)fileName;

# pragma mark - txt file add select delete

+ (void)saveTXTFileWithName:(NSString *)fileName contentString:(NSString *)contentString;

+ (void)removeTXTFileWithName:(NSString *)fileName;

+ (NSString *)getTXTFileWithName:(NSString *)fileName;

# pragma  mark - Directory

+ (void)saveTXTFileWithName:(NSString *)fileName directoryName:(NSString *)directoryName contentString:(NSString *)contentString;

+ (void)removeTXTFileWithName:(NSString *)fileName directoryName:(NSString *)directoryName;

+ (NSString *)getTXTFileWithName:(NSString *)fileName  directoryName:(NSString *)directoryName;

+ (NSArray *)getAllFileNameWithDirectoryName:(NSString *)directoryName;

# pragma  mark - Plist

+ (BOOL)savePlistFileWithName:(NSString *)fileName directoryName:(NSString *)directoryName contentDic:(NSDictionary *)contentDic;

+ (BOOL)removePlistFileWithName:(NSString *)fileName directoryName:(NSString *)directoryName;

+ (NSDictionary *)getPlistFileWithName:(NSString *)fileName  directoryName:(NSString *)directoryName;

@end

NS_ASSUME_NONNULL_END
