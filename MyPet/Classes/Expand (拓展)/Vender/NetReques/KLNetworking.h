//
//  KLNetworking.h
//  柯里Tool
//
//  Created by lzf on 2018/11/15.
//  Copyright © 2018 lzf. All rights reserved.
//

#import <Foundation/Foundation.h>
// https://wxaj.gzkjaj.com:8083/gzkjaj http://www.mihuo8.com:8081/gzkjaj
//#define BaseUrl  @"http://www.mihuo8.com:8081/gzkjaj/mob"
//#define ImageUrl @"http://www.mihuo8.com:8081/gzkjaj"
#define BaseUrl  @"http://gzkjaj.com:8081/gzkjaj/mob"
#define ImageUrl @"http://gzkjaj.com:8081/gzkjaj"
#define LNewBaseUrl  @"http://www.gzkjaj.com:8020/gzkjaj/mob"
#define LNewImageUrl @"http://www.gzkjaj.com:8020/gzkjaj"
#define BaseImageUrl(Url) [NSString stringWithFormat:@"%@%@",ImageUrl,Url]
#define BaseImageUrl2(Url) [NSString stringWithFormat:@"%@/%@",ImageUrl,Url]



NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HTTPMethod) {
    
    HTTPMethodGET,
    HTTPMethodPOST,
    HTTPMethodHEAD,
    HTTPMethodDELETE,
    HTTPMethodPUT,
};

@interface KLNetworking : NSObject

+ (instancetype)shareManager;

/**
 网络请求
 
 @param requestMethod 请求类型
 @param path 请求地址
 @param parameters 参数
 @param success 成功结果
 @param failure 失败结果
 */
- (void)sendRequestMethod:(HTTPMethod)requestMethod
                                                path:(nonnull NSString *)path
                                          parameters:(nullable NSDictionary *)parameters
                                             success:(nullable void(^) (BOOL isSuccess, id _Nullable responseObject))success
                                        failure:(nullable void(^) (id error))failure;


/**
 上传图片
 
 @param imageArray 图片
 @param keyName 字段名称
 @param width 图片质量
 @param progress 进度
 @param success 成功
 */
- (void)sendPOSTRequestWithpath:(nonnull NSString *)path
                     imageArray:(NSArray *_Nullable)imageArray
                        keyName:(NSString *)keyName
                         Parame:(NSDictionary *)parame
                    targetWidth:(CGFloat )width
                       progress:(nullable void (^)(NSProgress * _Nullable progress))progress
                        success:(nullable void(^) (BOOL isSuccess, id _Nullable responseObject))success
                        failure:(nullable void(^) (id error))failure;


- (void)downloadFileWihtURL:(NSString *)url
                    success:(nullable NSURL *(^) (BOOL isSuccess, id _Nullable responseObject))success
          completionHandler:(void (^)(void))completionHandler;



- (void)sendPOSTRequestWithpath:(NSString *)path
                           data:(NSData *)data
                        keyName:(NSString *)keyName
                         Parame:(NSDictionary *)parame
                    targetWidth:(CGFloat)width
                       progress:(void (^)(NSProgress * _Nullable))progress
                        success:(void (^)(BOOL, id _Nullable))success
                        failure:(void (^)(id _Nonnull))failure;

/**
 网络请求
 
 @param parameters 参数
 @param success 成功结果
 @param failure 失败结果
 */
- (void)sendParameters:(nullable NSDictionary *)parameters
               success:(nullable void(^) (BOOL isSuccess, id _Nullable responseObject))success
            failure:(nullable void(^) (id error))failure;

/**
 网络请求
 
 @param parameters 参数
 @param success 成功结果
 @param failure 失败结果
 */
- (void)sendRequestMethod:(HTTPMethod)requestMethod
                     url:(nonnull NSString *)url
               parameters:(nullable NSDictionary *)parameters
               success:(nullable void(^) (BOOL isSuccess, id _Nullable responseObject))success
            failure:(nullable void(^) (id error))failure;
@end

NS_ASSUME_NONNULL_END
