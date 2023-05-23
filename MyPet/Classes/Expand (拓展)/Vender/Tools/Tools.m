//
//  Tools.m
//  Tools
//
//  Created by 王健龙 on 2019/3/24.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "Tools.h"
#import <CommonCrypto/CommonDigest.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <Photos/PHPhotoLibrary.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"

#import "LoginViewController.h"
#import "AreaModel.h"
#import "YZAuthID.h"
#import "UIColor+hexColor.h"

@implementation Tools

//字符串高度
+ (CGFloat)stringHeightWith:(NSString *)str Width:(CGFloat)width Font:(CGFloat)fontSize{
    CGSize strSize = [str boundingRectWithSize:CGSizeMake(width, FLT_MAX)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}
                                       context: nil].size;
    return strSize.height;
}

//字符串宽度
+ (CGFloat)stringWidthtWith:(NSString *)str Height:(CGFloat)height Font:(CGFloat)fontSize{
    CGSize strSize = [str boundingRectWithSize:CGSizeMake(FLT_MAX, height)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}
                                       context: nil].size;
    return strSize.width;
}




// 添加阴影
+ (void)addShadowWithView:(UIView *)view {
    view.layer.shadowColor = RGBA(255, 255, 255, 1).CGColor;//阴影颜色
    view.layer.shadowOffset = CGSizeMake(0, 2);//偏移距离
    view.layer.shadowOpacity = 1;//不透明度
    view.layer.shadowRadius = 4;//阴影半径
}

// 添加阴影
+ (void)addShadowWithView2:(UIView *)view {
    view.layer.shadowColor = color_228.CGColor;//阴影颜色
    view.layer.shadowOffset = CGSizeMake(0,3);//偏移距离
    view.layer.shadowOpacity = 0.5;//不透明度
    view.layer.shadowRadius = 3;//阴影半径
}

// 添加阴影
+ (void)addShadowWithView3:(UIView *)view {
    view.clipsToBounds = NO;
    view.layer.shadowColor = RGBA(0, 0, 0, 0.12).CGColor;//阴影颜色
    view.layer.shadowOffset = CGSizeMake(0, 2);//偏移距离
    view.layer.shadowOpacity = 1;//不透明度
    view.layer.shadowRadius = 4;//阴影半径
}



// 添加阴影
+ (void)addShadowWithButton:(UIView *)view {
    view.layer.shadowColor = RGBA(255, 71, 52, 0.24).CGColor;//阴影颜色
    view.layer.shadowOffset = CGSizeMake(0, 3);//偏移距离
    view.layer.shadowOpacity = 1;//不透明度
    view.layer.shadowRadius = 5;//阴影半径
}

/// 切指定部位圆角
/// @param view view
/// @param corners 部位
/// @param cornerRadii 大小
+ (void)viewRadiusWithView:(UIView *)view byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:cornerRadii].CGPath;
    view.layer.mask = shapeLayer;
}

/**
 字符串变色-单个
 
 @param str 字符串
 @param color 颜色
 @param range 位置
 @return 变色的字符串
 */
+ (NSMutableAttributedString *)stringColorWithString:(NSString *)str color:(UIColor *)color range:(NSRange)range {
    NSMutableAttributedString *tempStr = [[NSMutableAttributedString alloc] initWithString:str];
    [tempStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    return tempStr;
}

#pragma mark - 获取当前控制器
+ (UIViewController *)getCurrentVC {
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    UIViewController* currentViewController = window.rootViewController;
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}

#pragma mark MD5
//参数加密
+ (NSString *)MD5:(NSString *)str {
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( input, (CC_LONG)strlen(input), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

#pragma mark 字典排序并拼接
+ (NSString *)stringNSmutableDictionary:(NSDictionary *)dict {
    
    NSArray *keysArray = [dict allKeys];
    
    //系统自带排序方式
    NSArray *sorkArray = [keysArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *sortSting in sorkArray) {
        [valueArray addObject:[dict objectForKey:sortSting]];
    }
    
    NSMutableArray *signArray = [NSMutableArray array];
    for (int i = 0; i < sorkArray.count; i ++) {
        NSString *keyValues = [NSString stringWithFormat:@"%@=%@",sorkArray[i],valueArray[i]];
        [signArray addObject:keyValues];
    }
    
    NSString *sign = [signArray componentsJoinedByString:@"&"];
    
    return sign;
}

#pragma mark - 处理状态码
+ (void)handleServerStatusCodeDictionary:(NSDictionary *)dic {
    if (dic) {
        NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"msg"] ?: [dic objectForKey:@"message"]];
        if ([dic[@"code"] integerValue] != 618) {
            [SVProgressHUD dismissWithDelay:1.5];
        }
        [SVProgressHUD showErrorWithStatus:message];
        
        if ([dic[@"code"] integerValue] ==  514 ||
            [dic[@"code"] integerValue] ==  546 ||
            [dic[@"code"] integerValue] ==  401) {
            [UserManager deleteUserInfo];

//            LogViewController *vc = [LogViewController new];
//            vc.noLoginBlock = ^{
//                [[Tools getCurrentVC].navigationController popViewControllerAnimated:YES];
//            };
//
//            if (![[Tools getCurrentVC].navigationController.viewControllers.lastObject isKindOfClass:[LogViewController class]]) {
//                [[Tools getCurrentVC].navigationController pushViewController:vc animated:YES];
//            }
        }
    }
}

/**
 千位符
 
 @param str 字符串
 @return 字符串
 */
+(NSString *)stringTurnMoney:(NSString *)str {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:@"###############,###;"];
    
    NSString *balance = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:[str integerValue]]];
    
    return balance;
}


#pragma mark - 省市区数据
/// 获取省市区版本号
+ (void)getProvinceCityAreaVersion {
    /*
    [[KLNetworking shareManager] sendRequestMethod:HTTPMethodGET path:@"/address/provinceCityAreaVersion" parameters:@{} success:^(BOOL isSuccess, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == RequestSuccess) {
            // 云端版本
            NSNumber * areaVersion = responseObject[@"data"][@"provinceCityAreaVersion"];
            // 本地版本
            NSNumber * currentAreaVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"provinceCityAreaVersion"];
            // 相同不用重新请求
            if ([areaVersion integerValue] == [currentAreaVersion integerValue]) {
                [[NSUserDefaults standardUserDefaults] setObject:areaVersion forKey:@"provinceCityAreaVersion"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            } else {
                [self houseCity];
                [self provinceCity];
                [self getProvinceCityArea];
            }
        } else {
            [Tools handleServerStatusCodeDictionary:responseObject];
        }
     
    } failure:^(id  _Nonnull error) {
        
    }];
     */
    [self houseCity];
    [self provinceCity];
    [self getProvinceCityArea];
}

/// 获取有房源的城市列表
+ (void)houseCity {
    [[KLNetworking shareManager] sendRequestMethod:HTTPMethodGET path:@"/house/cityList" parameters:@{} success:^(BOOL isSuccess, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == RequestSuccess) {
            NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"houseCity.plist"];
            [responseObject[@"data"] writeToFile:filePatch atomically:YES];
        } else {
            [Tools handleServerStatusCodeDictionary:responseObject];
        }
    } failure:^(id  _Nonnull error) {
        
    }];
}

/// 获取有房源的城市列表
+ (NSMutableArray *)getHouseCity {
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"houseCity.plist"];
    NSMutableArray *tempArray = [NSMutableArray arrayWithContentsOfFile:filePatch];
    if (tempArray.count == 0) {
        [self houseCity];
    }
    return tempArray;
}


/// 请求省市二级联动数据
+ (void)provinceCity {
    [[KLNetworking shareManager] sendRequestMethod:HTTPMethodGET path:@"/address/provinceCity" parameters:@{} success:^(BOOL isSuccess, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == RequestSuccess) {
            NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"provinceCity.plist"];
            [responseObject[@"data"] writeToFile:filePatch atomically:YES];
        } else {
            [Tools handleServerStatusCodeDictionary:responseObject];
        }
    } failure:^(id  _Nonnull error) {
        
    }];
}


/// 获取省市二级联动
+ (NSMutableArray *)getProvinceCity {
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"provinceCity.plist"];
    NSMutableArray *tempArray = [NSMutableArray arrayWithContentsOfFile:filePatch];
    if (tempArray.count == 0) {
        [self provinceCity];
    }
    return tempArray;
}

/// 请求省市区三级联动数据
+ (void)provinceCityArea {
    [[KLNetworking shareManager] sendRequestMethod:HTTPMethodGET path:@"/address/provinceCityArea" parameters:@{} success:^(BOOL isSuccess, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == RequestSuccess) {
            NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"provinceCityArea.plist"];
            [responseObject[@"data"] writeToFile:filePatch atomically:YES];
        } else {
            [Tools handleServerStatusCodeDictionary:responseObject];
        }
    } failure:^(id  _Nonnull error) {
        
    }];
}

/// 获取省市区三级联动
+ (NSMutableArray *)getProvinceCityArea {
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"provinceCityArea.plist"];
    NSMutableArray *tempArray = [NSMutableArray arrayWithContentsOfFile:filePatch];
    if (tempArray.count == 0) {
        [self provinceCityArea];
    }
    return tempArray;
}

//获取省市区三级联动数据
+ (void)getRegionDataSuccess:(void (^)(NSArray *))success failure:(nullable void(^) (id error))failure {
    [SVProgressHUD show];
    [[KLNetworking shareManager] sendRequestMethod:HTTPMethodGET path:@"/region/getAllRegion" parameters:@{} success:^(BOOL isSuccess, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == NewRequestSuccess) {
            RegionDataModel *dataModel = [[RegionDataModel alloc] initWithDictionary:responseObject error:nil];
            success(dataModel.data);
        } else {
            [Tools handleServerStatusCodeDictionary:responseObject];
        }
        [SVProgressHUD dismiss];

    } failure:^(id  _Nonnull error) {
        [SVProgressHUD dismiss];
        failure(error);
    }];
}


/// 评估价格选择城市
+ (void)selectProvinceCityAreaAll {
    [[KLNetworking shareManager] sendRequestMethod:HTTPMethodGET path:@"/assess/selectProvinceCityAreaAll" parameters:@{} success:^(BOOL isSuccess, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == RequestSuccess) {
            NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"selectProvinceCityAreaAll.plist"];
            [responseObject[@"data"] writeToFile:filePatch atomically:YES];
        } else {
            [Tools handleServerStatusCodeDictionary:responseObject];
        }
    } failure:^(id  _Nonnull error) {
        
    }];
}

/// 评估价格选择城市
+ (NSMutableArray *)getSelectProvinceCityAreaAll {
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"selectProvinceCityAreaAll.plist"];
    NSMutableArray *tempArray = [NSMutableArray arrayWithContentsOfFile:filePatch];
    if (tempArray.count == 0) {
        [self selectProvinceCityAreaAll];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"selectProvinceCityAreaAll"ofType:@"plist"];
        tempArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    }
    return tempArray;
}


#pragma mark - 拨打电话
+ (void)callPhone:(NSString *)number {
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]];
    if (@available(iOS 10.0, *)) {
        if ([[UIApplication sharedApplication] canOpenURL:URL]) {
            [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:^(BOOL success) {
            }];
        }
    } else {
//        [[UIApplication sharedApplication] openURL:URL];
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];

    }
}

#pragma mark - 打开safari
+ (void)openSafari:(NSString *)url {
    NSURL *URL = [NSURL URLWithString:url];
    if (@available(iOS 10.0, *)) {
        if ([[UIApplication sharedApplication] canOpenURL:URL]) {
            [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:^(BOOL success) {
            }];
        }
    } else {
//        [[UIApplication sharedApplication] openURL:URL];
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
    }
}

#pragma mark - 能否使用相机
+ (BOOL)isCarameAvailable:(UIViewController *)controller {
    //判断权限
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        MLAlertView * alertView = [[MLAlertView alloc] initWithTitle:@"相机授权未开启" andMessage:@"请在系统设置中开启相机授权" andMessageAlignment:NSTextAlignmentCenter andItem:@[@"取消",@"去开启"] andSelectBlock:^(NSInteger index) {
            if (index == 1) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url])
                {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
//                    [[UIApplication sharedApplication] openURL:url];
                }
            }
            
        }];
        [alertView showWithView:controller.view];
        
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - 能否使用相册
+ (BOOL)isPhotosAvailable:(UIViewController *)controller {
    //相册权限
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied ) {
        MLAlertView * alertView = [[MLAlertView alloc] initWithTitle:@"相册授权未开启" andMessage:@"请在系统设置中开启相册授权" andMessageAlignment:NSTextAlignmentCenter andItem:@[@"取消",@"去开启"] andSelectBlock:^(NSInteger index) {
            if (index == 1) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url])
                {
//                    [[UIApplication sharedApplication] openURL:url];
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                }
            }
            
        }];
        [alertView showWithView:controller.view];
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - 能否使用定位
+ (BOOL)isLocationAvailable:(UIViewController *)controller {
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        return YES;
    } else {
        MLAlertView * alertView = [[MLAlertView alloc] initWithTitle:@"定位服务未开启" andMessage:@"请在系统设置中开启定位服务" andMessageAlignment:NSTextAlignmentCenter andItem:@[@"取消",@"去开启"] andSelectBlock:^(NSInteger index) {
            if (index == 1) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url])
                {
//                    [[UIApplication sharedApplication] openURL:url];
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                }
            } 
            
        }];
        [alertView showWithView:[UIApplication sharedApplication].keyWindow];
        return NO;
    }
}


/**
 检查是否包含两个以上汉字

 @param str 字符串
 @return bool
 */
+ (BOOL)findingChineseCharactersWithStr:(NSString *)str {
    NSMutableArray *textArray = [NSMutableArray array];
    for (NSInteger i = 0; i <str.length ; i++) {
        NSString *text = [str substringWithRange:NSMakeRange(i, 1)];
        [textArray addObject:text];
    }
    if (textArray.count > 1) {
        BOOL isChinese = NO;
        for (NSUInteger i = 0; i < textArray.count; i = i + 1) {
            int a = [str characterAtIndex:i];
            if ( a > 0x4e00 && a < 0x9fff) {
                if (isChinese) {
                    return YES;
                } else {
                    isChinese = YES;
                }
            } else {
                return NO;
            }
        }
    }
    return NO;
}


+ (NSString *)lastUpdataAnswerTime:(NSString *)AnswerTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:AnswerTime];
    NSTimeInterval oldTime = [date timeIntervalSince1970];
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    NSUInteger reduceTime = nowTime - oldTime;
    
    //格式化日期
    NSUInteger minute = 60;
    NSUInteger hour = minute*60;
    NSUInteger day = hour*24;
    NSUInteger weak = day*6;
    NSUInteger month = day*30;
    NSUInteger year = day*365;
    if (reduceTime > 0 && reduceTime <= hour){
        return [NSString stringWithFormat:@"%ld分钟前回答了问题", reduceTime/minute];
    }else if (reduceTime > hour && reduceTime <= day){
        return [NSString stringWithFormat:@"%ld小时前回答了问题", reduceTime/hour];
    }else if (reduceTime > day && reduceTime <= weak) {
        return [NSString stringWithFormat:@"%ld天前回答了问题", reduceTime/day];
    }else if (reduceTime > weak && reduceTime <= month) {
        return [NSString stringWithFormat:@"%ld星期前回答了问题", reduceTime/weak];
    } else if (reduceTime > month && reduceTime <= year) {
        return [NSString stringWithFormat:@"%ld月前回答了问题", reduceTime/month];
    }else{
        return [NSString stringWithFormat:@"%ld年前回答了问题", reduceTime/year];
    }
}

+ (NSString *)lastTimeWith:(NSString *)AnswerTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:AnswerTime];
    NSTimeInterval oldTime = [date timeIntervalSince1970];
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    NSUInteger reduceTime = nowTime - oldTime;
    
    //格式化日期
    NSUInteger minute = 60;
    NSUInteger hour = minute*60;
    NSUInteger day = hour*24;
    NSUInteger weak = day*6;
    NSUInteger month = day*30;
    NSUInteger year = day*365;
    if (reduceTime > 0 && reduceTime <= hour){
        return [NSString stringWithFormat:@"%ld分钟前", reduceTime/minute];
    }else if (reduceTime > hour && reduceTime <= day){
        return [NSString stringWithFormat:@"%ld小时前", reduceTime/hour];
    }else if (reduceTime > day && reduceTime <= weak) {
        return [NSString stringWithFormat:@"%ld天前", reduceTime/day];
    }else if (reduceTime > weak && reduceTime <= month) {
        return [NSString stringWithFormat:@"%ld星期前", reduceTime/weak];
    } else if (reduceTime > month && reduceTime <= year) {
        return [NSString stringWithFormat:@"%ld月前", reduceTime/month];
    }else{
        return [NSString stringWithFormat:@"%ld年前", reduceTime/year];
    }
}


+ (NSString *)convertedToUtf8StringWithData:(NSData *)data{
    
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (string == nil) {
        string = [[NSString alloc] initWithData:[self UTF8DataWithData:data] encoding:NSUTF8StringEncoding];
    }
    return string;
    
}

+ (NSData *)UTF8DataWithData:(NSData *)data {
    
    //保存结果
    NSMutableData *resData = [[NSMutableData alloc] initWithCapacity:data.length];
    
    NSData *replacement = [@"�" dataUsingEncoding:NSUTF8StringEncoding];
    
    uint64_t index = 0;
    const uint8_t *bytes = data.bytes;
    
    long dataLength = (long) data.length;
    
    while (index < dataLength) {
        uint8_t len = 0;
        uint8_t firstChar = bytes[index];
        
        // 1个字节
        if ((firstChar & 0x80) == 0 && (firstChar == 0x09 || firstChar == 0x0A || firstChar == 0x0D || (0x20 <= firstChar && firstChar <= 0x7E))) {
            len = 1;
        }
        // 2字节
        else if ((firstChar & 0xE0) == 0xC0 && (0xC2 <= firstChar && firstChar <= 0xDF)) {
            if (index + 1 < dataLength) {
                uint8_t secondChar = bytes[index + 1];
                if (0x80 <= secondChar && secondChar <= 0xBF) {
                    len = 2;
                }
            }
        }
        // 3字节
        else if ((firstChar & 0xF0) == 0xE0) {
            if (index + 2 < dataLength) {
                uint8_t secondChar = bytes[index + 1];
                uint8_t thirdChar = bytes[index + 2];
                
                if (firstChar == 0xE0 && (0xA0 <= secondChar && secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF)) {
                    len = 3;
                } else if (((0xE1 <= firstChar && firstChar <= 0xEC) || firstChar == 0xEE || firstChar == 0xEF) && (0x80 <= secondChar && secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF)) {
                    len = 3;
                } else if (firstChar == 0xED && (0x80 <= secondChar && secondChar <= 0x9F) && (0x80 <= thirdChar && thirdChar <= 0xBF)) {
                    len = 3;
                }
            }
        }
        // 4字节
        else if ((firstChar & 0xF8) == 0xF0) {
            if (index + 3 < dataLength) {
                uint8_t secondChar = bytes[index + 1];
                uint8_t thirdChar = bytes[index + 2];
                uint8_t fourthChar = bytes[index + 3];
                
                if (firstChar == 0xF0) {
                    if ((0x90 <= secondChar & secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF) && (0x80 <= fourthChar && fourthChar <= 0xBF)) {
                        len = 4;
                    }
                } else if ((0xF1 <= firstChar && firstChar <= 0xF3)) {
                    if ((0x80 <= secondChar && secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF) && (0x80 <= fourthChar && fourthChar <= 0xBF)) {
                        len = 4;
                    }
                } else if (firstChar == 0xF3) {
                    if ((0x80 <= secondChar && secondChar <= 0x8F) && (0x80 <= thirdChar && thirdChar <= 0xBF) && (0x80 <= fourthChar && fourthChar <= 0xBF)) {
                        len = 4;
                    }
                }
            }
        }
        // 5个字节
        else if ((firstChar & 0xFC) == 0xF8) {
            len = 0;
        }
        // 6个字节
        else if ((firstChar & 0xFE) == 0xFC) {
            len = 0;
        }
        
        if (len == 0) {
            index++;
            [resData appendData:replacement];
        } else {
            [resData appendBytes:bytes + index length:len];
            index += len;
        }
    }
    
    return resData;
    
}

#pragma mark - 验证TouchID/FaceID

+ (void)authVerificationSuccess:(void (^)(BOOL))success {
    //添加高斯模糊背景
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    effectview.frame = window.frame;
    [window addSubview:effectview];
    
    YZAuthID *authID = [[YZAuthID alloc] init];
    [authID yz_showAuthIDWithDescribe:nil block:^(YZAuthIDState state, NSError *error) {
        // 不支持TouchID/FaceID
        // 无法启动,因为用户没有设置密码
        [effectview removeFromSuperview];
        if (state == YZAuthIDStateNotSupport || state == YZAuthIDStateSystemCancel) {
            success(NO);
        } else if (state == YZAuthIDStateSuccess) { // TouchID/FaceID验证成功
            NSLog(@"认证成功！");
            success(YES);
        } else  { //其他错误
            success(NO);
        }
    }];

}


+ (NSString *)formatDecimalNumber:(NSString *)string {
    if (!string || string.length == 0) {
        return string ?: @"0";
    }
    NSNumber *number = @([string doubleValue]);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    
    if ([string containsString:@"."]) {
        NSRange rang = [string rangeOfString:@"."];
        if (string.length - rang.location == 0) {
            formatter.positiveFormat = @"###,##0";
        } else if (string.length - rang.location == 1) {
            formatter.positiveFormat = @"###,##0.0";
        } else {
            formatter.positiveFormat = @"###,##0.00";
        }
    } else {
        formatter.positiveFormat = @"###,##0";
    }
    
    NSString *amountString = [formatter stringFromNumber:number];
    return amountString;
}


@end
