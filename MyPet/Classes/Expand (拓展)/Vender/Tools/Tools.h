//
//  Tools.h
//  Tools
//
//  Created by 王健龙 on 2019/3/24.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tools : NSObject

/**
 字符串高度
 
 @param str 字符串
 @param width 宽度
 @param fontSize 大小
 @return 高度
 */
+ (CGFloat)stringHeightWith:(NSString *)str Width:(CGFloat)width Font:(CGFloat)fontSize;


/**
 字符串宽度
 
 @param str 字符串
 @param height 宽度
 @param fontSize 大小
 @return 高度
 */
+ (CGFloat)stringWidthtWith:(NSString *)str Height:(CGFloat)height Font:(CGFloat)fontSize;


// 添加阴影
+ (void)addShadowWithView:(UIView *)view;

// 添加阴影
+ (void)addShadowWithView2:(UIView *)view;

// 添加阴影
+ (void)addShadowWithView3:(UIView *)view;

// 添加阴影
+ (void)addShadowWithButton:(UIView *)view;

/// 切指定部位圆角
/// @param view view
/// @param corners 部位
/// @param cornerRadii 大小
+ (void)viewRadiusWithView:(UIView *)view byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

/**
 字符串变色-单个
 
 @param str 字符串
 @param color 颜色
 @param range 位置
 @return 变色的字符串
 */
+ (NSMutableAttributedString *)stringColorWithString:(NSString *)str color:(UIColor *)color range:(NSRange)range;

// 获取当前控制器
+ (UIViewController *)getCurrentVC;

#pragma mark MD5
//参数加密
+ (NSString *)MD5:(NSString *)str;

#pragma mark 字典排序并拼接
+ (NSString *)stringNSmutableDictionary:(NSDictionary *)dict;

/** 处理状态码 */
+ (void)handleServerStatusCodeDictionary:(NSDictionary *)dic;

/**
 千位符
 
 @param str 字符串
 @return 字符串
 */
+(NSString *)stringTurnMoney:(NSString *)str;


#pragma mark - 省市区数据
/// 获取省市区版本号
+ (void)getProvinceCityAreaVersion;
/// 获取有房源的城市列表
+ (NSMutableArray *)getHouseCity;
/// 获取省市二级联动
+ (NSMutableArray *)getProvinceCity;
/// 获取省市区三级联动
+ (NSMutableArray *)getProvinceCityArea;
/// 评估价格选择城市
+ (NSMutableArray *)getSelectProvinceCityAreaAll;

//获取省市区三级联动数据
+ (void)getRegionDataSuccess:(void (^)(NSArray *))success failure:(nullable void(^) (id error))failure;


#pragma mark - 拨打电话
+ (void)callPhone:(NSString *)number;
#pragma mark - 打开safari
+ (void)openSafari:(NSString *)url;
#pragma mark - 能否使用相机
+ (BOOL)isCarameAvailable:(UIViewController *)controller;
#pragma mark - 能否使用相册
+ (BOOL)isPhotosAvailable:(UIViewController *)controller;
#pragma mark - 能否使用定位
+ (BOOL)isLocationAvailable:(UIViewController *)controller;

/**
 检查是否包含两个以上汉字
 
 @param str 字符串
 @return bool
 */
+ (BOOL)findingChineseCharactersWithStr:(NSString *)str;


/**
 最后回答问题时间

 @param AnswerTime 时间
 @return str
 */
+ (NSString *)lastUpdataAnswerTime:(NSString *)AnswerTime;

+ (NSString *)convertedToUtf8StringWithData:(NSData *)data;

+ (NSString *)lastTimeWith:(NSString *)AnswerTime;


#pragma mark - 验证TouchID/FaceID
+ (void)authVerificationSuccess:(void (^)(BOOL))success;

+ (NSString *)formatDecimalNumber:(NSString *)string;


@end
NS_ASSUME_NONNULL_END

