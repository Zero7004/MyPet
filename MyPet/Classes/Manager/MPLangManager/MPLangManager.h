//
//  MPLangManager.h
//  MyPet
//
//  Created by long on 2023/5/30.
//  Copyright © 2023 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * _Nullable const MPLangManagerType_EN = @"en";
static NSString * _Nullable const MPLangManagerType_CN = @"zh_CN";

NS_ASSUME_NONNULL_BEGIN

@interface MPLangManager : NSObject

+ (MPLangManager *)shareInstance;

- (NSString *)getCurLang;

- (void)setChangeLang:(NSString *)lang;


@end

NS_ASSUME_NONNULL_END
