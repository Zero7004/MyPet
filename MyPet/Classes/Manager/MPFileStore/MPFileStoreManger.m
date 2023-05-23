//
//  MPFileStoreManger.m
//  MyPet
//
//  Created by long on 2023/5/23.
//  Copyright © 2023 王健龙. All rights reserved.
//

#import "MPFileStoreManger.h"

@implementation MPFileStoreManger

# pragma mark - json file add select delete

+ (void)saveJsonFileWithName:(NSString *)fileName jsonDic:(NSDictionary *)jsonDic
{
    fileName = [NSString stringWithFormat:@"%@.json",fileName];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName]; //Add the file name
    [jsonDic writeToFile:filePath atomically:YES];
}

+ (void)removeJsonFileWithName:(NSString *)fileName
{
    fileName = [NSString stringWithFormat:@"%@.json",fileName];
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *fileInDocumentPath = [documentPath stringByAppendingPathComponent:fileName];
    [fileManger removeItemAtPath:fileInDocumentPath error:nil];
}

+ (NSDictionary *)getJsonFileWithName:(NSString *)fileName
{
    fileName = [NSString stringWithFormat:@"%@.json",fileName];
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *fileInDocumentPath = [documentPath stringByAppendingPathComponent:fileName];
    NSDictionary *jsonDic = [NSDictionary dictionaryWithContentsOfFile:fileInDocumentPath];
    return jsonDic;
}

+ (void)saveStaticJsonFileName:(NSString *)fileName jsonDic:(NSDictionary *)jsonDic {
   
    NSString  *jsonName = [NSString stringWithFormat:@"%@.json",fileName];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fileDic = [documentsDirectory stringByAppendingPathComponent:@"static"];
    
    BOOL isDic;
    if(![fileManager fileExistsAtPath:fileDic  isDirectory:&isDic] || !isDic) {
        [fileManager createDirectoryAtPath:fileDic withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePath = [fileDic stringByAppendingPathComponent:jsonName];
    [jsonDic writeToFile:filePath atomically:YES];
}

+ (void)removeStaticJsonFileWithName:(NSString *)fileName {
    
    NSString  *jsonName = [NSString stringWithFormat:@"%@.json",fileName];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fileDic = [documentsDirectory stringByAppendingPathComponent:@"static"];
    
    BOOL isDic;
    if(![fileManager fileExistsAtPath:fileDic  isDirectory:&isDic] || !isDic) return;
    
    NSString *filePath = [fileDic stringByAppendingPathComponent:jsonName];
    [fileManager removeItemAtPath:filePath error:nil];
}

+ (NSDictionary *)getStaticJsonFileWithJsonName:(NSString *)fileName {
    
    NSString  *jsonName = [NSString stringWithFormat:@"%@.json",fileName];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fileDic = [documentsDirectory stringByAppendingPathComponent:@"static"];
    
    BOOL isDic;
    if(![fileManager fileExistsAtPath:fileDic  isDirectory:&isDic] || !isDic) {
        return nil;
    }

    NSString *filePath = [fileDic stringByAppendingPathComponent:jsonName];
    NSDictionary *jsonDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return jsonDic;
}

# pragma mark - txt file add select delete

+ (void)saveTXTFileWithName:(NSString *)fileName contentString:(NSString *)contentString
{
    if (![fileName containsString:@".txt"]){
        
        fileName = [NSString stringWithFormat:@"%@.txt",fileName];
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName]; //Add the file name
    [contentString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (void)removeTXTFileWithName:(NSString *)fileName
{
    if (![fileName containsString:@".txt"]){
        
        fileName = [NSString stringWithFormat:@"%@.txt",fileName];
    }
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *fileInDocumentPath = [documentPath stringByAppendingPathComponent:fileName];
    [fileManger removeItemAtPath:fileInDocumentPath error:nil];
}

+ (NSString *)getTXTFileWithName:(NSString *)fileName
{
    if (![fileName containsString:@".txt"]){
        
        fileName = [NSString stringWithFormat:@"%@.txt",fileName];
    }
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *fileInDocumentPath = [documentPath stringByAppendingPathComponent:fileName];
    NSString *contentString = [NSString stringWithContentsOfFile:fileInDocumentPath encoding:NSUTF8StringEncoding error:nil];
    return contentString;
}

# pragma  mark - Directory

+ (void)saveTXTFileWithName:(NSString *)fileName directoryName:(NSString *)directoryName contentString:(NSString *)contentString
{
    if (![fileName containsString:@".txt"]){
        
        fileName = [NSString stringWithFormat:@"%@.txt",fileName];
    }
    //获取Document文件
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * rarFilePath = [docsdir stringByAppendingPathComponent:directoryName];//将需要创建的串拼接到后面
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:rarFilePath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) {//如果文件夹不存在
        [fileManager createDirectoryAtPath:rarFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePath = [rarFilePath stringByAppendingPathComponent:fileName]; //Add the file name
    [contentString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (void)removeTXTFileWithName:(NSString *)fileName directoryName:(NSString *)directoryName
{
    if (![fileName containsString:@".txt"]){
        
        fileName = [NSString stringWithFormat:@"%@.txt",fileName];
    }
    
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * rarFilePath = [docsdir stringByAppendingPathComponent:directoryName];//将需要创建的串拼接到后面
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [rarFilePath stringByAppendingPathComponent:fileName]; //Add the file name
    [fileManager removeItemAtPath:filePath error:nil];
}

+ (NSString *)getTXTFileWithName:(NSString *)fileName  directoryName:(NSString *)directoryName
{
    if (![fileName containsString:@".txt"]){
        
        fileName = [NSString stringWithFormat:@"%@.txt",fileName];
    }
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * rarFilePath = [docsdir stringByAppendingPathComponent:directoryName];//将需要创建的串拼接到后面
    NSString *filePath = [rarFilePath stringByAppendingPathComponent:fileName]; //Add the file name
    NSString *contentString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    return contentString;
}

+ (NSArray *)getAllFileNameWithDirectoryName:(NSString *)directoryName{
    
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    // [patchs objectAtIndex:0]
    NSString *fileDirectory = [documentPath stringByAppendingPathComponent:directoryName];
    
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:fileDirectory error:nil];
    return files;
}


# pragma  mark - Plist

+ (BOOL)savePlistFileWithName:(NSString *)fileName directoryName:(NSString *)directoryName contentDic:(NSDictionary *)contentDic{
    
    if (![fileName containsString:@".plist"]){
        
        fileName = [NSString stringWithFormat:@"%@.plist",fileName];
    }
    
    NSMutableDictionary *oldContentDic = [self getPlistFileWithName:fileName directoryName:directoryName].mutableCopy;
    if (oldContentDic.count > 0){
        
        for (NSString *key in contentDic.allKeys){
            
            [oldContentDic setValue:[contentDic objectForKey:key] forKey:key];
        }
        contentDic = oldContentDic.copy;
    }
    
    //获取Document文件
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * rarFilePath = [docsdir stringByAppendingPathComponent:directoryName];//将需要创建的串拼接到后面
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:rarFilePath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) {//如果文件夹不存在
        [fileManager createDirectoryAtPath:rarFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePath = [rarFilePath stringByAppendingPathComponent:fileName]; //Add the file name
    return [contentDic writeToFile:filePath atomically:YES];
}

+ (BOOL)removePlistFileWithName:(NSString *)fileName directoryName:(NSString *)directoryName{
    
    if (![fileName containsString:@".plist"]){
        
        fileName = [NSString stringWithFormat:@"%@.plist",fileName];
    }
    
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * rarFilePath = [docsdir stringByAppendingPathComponent:directoryName];//将需要创建的串拼接到后面
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [rarFilePath stringByAppendingPathComponent:fileName]; //Add the file name
    return [fileManager removeItemAtPath:filePath error:nil];
}

+ (NSDictionary *)getPlistFileWithName:(NSString *)fileName  directoryName:(NSString *)directoryName{
    
    if (![fileName containsString:@".plist"]){
        
        fileName = [NSString stringWithFormat:@"%@.plist",fileName];
    }
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * rarFilePath = [docsdir stringByAppendingPathComponent:directoryName];//将需要创建的串拼接到后面
    NSString *filePath = [rarFilePath stringByAppendingPathComponent:fileName]; //Add the file name
    NSDictionary *content = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return content;
}

@end
