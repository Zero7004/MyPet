//
//  MPLangManager.m
//  MyPet
//
//  Created by long on 2023/5/30.
//  Copyright © 2023 王健龙. All rights reserved.
//

#import "MPLangManager.h"
#import "MPUserDefaultManager.h"

@interface MPLangManager ()

@property (nonatomic, copy) NSString *curLang;

@end

@implementation MPLangManager

+ (MPLangManager *)shareInstance{
    static MPLangManager *instance =  nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance initData];
    });
    return instance;
}

- (void)initData {
    
    if([MPUserDefaultManager getLang] == nil){
        
        if ([MPUserDefaultManager getValueForKey:@"lang"]) {
                
            [MPUserDefaultManager setLangWithValue:[MPUserDefaultManager getValueForKey:@"lang"]];
        } else {
            
            NSArray * apple_languages = [MPUserDefaultManager getValueForKey:@"AppleLanguages"];
            NSString *system_language = [apple_languages objectAtIndex:0];
            
            if ([system_language rangeOfString:@"zh-Hans"].location != NSNotFound || [system_language rangeOfString:@"zh-Hans-CN"].location != NSNotFound) {
                
                [MPUserDefaultManager setLangWithValue:@"zh_CN"];
                
            } else {
                
                [MPUserDefaultManager setLangWithValue:@"en"];
                
            }
        }
    }
    self.curLang = [MPUserDefaultManager getLang];
}

#pragma mark - public Method

- (NSString *)getCurLang {
    return self.curLang;
}

- (void)setChangeLang:(NSString *)lang {
    self.curLang = lang;
    [MPUserDefaultManager setLangWithValue:lang];
}


@end
