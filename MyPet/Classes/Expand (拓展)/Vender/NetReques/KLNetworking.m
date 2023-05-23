//
//  KLNetworking.m
//  柯里Tool
//
//  Created by lzf on 2018/11/15.
//  Copyright © 2018 lzf. All rights reserved.
//

#import "KLNetworking.h"
#import "AFNetworking.h"

@interface KLNetworking ()<NSURLConnectionDataDelegate>

//普通
@property (nonatomic, strong)AFHTTPSessionManager *manager;
@end

@implementation KLNetworking

+ (instancetype)shareManager {
    static KLNetworking *networkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[KLNetworking alloc] init];
    });
    return networkManager;
}


- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.requestSerializer.timeoutInterval = 50;//超时时间
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/plain",@"application/javascript", @"text/javascript",@"text/html",@"application/x-www-form-urlencoded",@"Content-Type:application/x-www-form-urlencoded",@"Content-Type:application/x-www-form-urlencoded;charset=utf-8",nil];
        
        AFSecurityPolicy *securityPolicy =  [AFSecurityPolicy defaultPolicy];
        // 客户端是否信任非法证书
        securityPolicy.allowInvalidCertificates = YES;
        // 是否在证书域字段中验证域名
        securityPolicy.validatesDomainName = NO;
        _manager.securityPolicy = securityPolicy;
        //设置请求头
        [_manager.requestSerializer setValue:[UserManager currentUser].usertoken?:@"" forHTTPHeaderField:@"usertoken"];
    }
    return _manager;
}


// TODO: - 已接新接口
- (NSArray *)urlPath {
    NSArray *tempPath = @[
        @"/login/loginByMobilePwd",
        @"/validate/sendCode",
        @"/login/bindPhone",
        @"/login/loginByVerificationCode",
        @"/login/forgotPwd",
        @"/login/iosBindPhone",
        @"/login/iosLoginAndRegister",
        @"/login/logout",
        @"/login/registered",
        @"/login/setPassword",
        @"/login/wXLoginAndRegister",
        @"/user/headUpload",
        @"/user/update",
        @"/poster/queryByPosterType",
        @"/suggestion/submitFeedBack",
        @"/article/search",
        @"/article/getArticle",
        @"/article/getArticleDetail",
        @"/user/updateNickName",
        @"/user/updatePwd",
        @"/file/imageUpload",
        @"/user/isCapitalPwdExist",
        @"/user/setCapitalPwd",
        @"/user/updateCapitalPwd",
        @"/user/forgotCapitalPwd",
        @"/user/findCustomer",
        @"/address/search",
        @"/address/create",
        @"/address/update",
        @"/address/delete",
        @"/creditReview/queryCreditReviewConfig",
        @"/creditReview/creditReviewOrderList",
        @"/creditReview/queryElectronicSignature",
        @"/creditReview/queryOrderByOrderNo",
        @"/authentiction/getAuthentication",
        @"/authentiction/firstAuthentication",
        @"/authentiction/secondAuthentication",
        @"/authentiction/thirdAuthentication",
        @"/authentiction/queryReadInformation",
        @"/authentiction/queryJurisdiction",
        @"/order/list",
        @"/order/detail",
        @"/team/getMyTeam",
        @"/team/getFirstTeam",
        @"/team/getSecondTeam",
        @"/info/queryInformationTypeList",
        @"/info/list",
        @"/info/queryById",
        @"/productFirst/list",
        @"/productFirst/create",
        @"/productFirst/queryStandardProduct",
        @"/order/teamList",
        @"/team/getInviteDesc",
        @"/team/getInviteDescByVipLevel",
        @"/productFirst/queryAll",
        @"/productApply/queryConfig",
        @"/productApply/payment",
        @"/productApply/create",
        @"/productApply/myProductApplyList",
        @"/productApply/revocation",
        @"/creditReview/queryIsStart",
        @"/creditReview/payment",
        @"/creditReview/search",
        @"/bourse/home",
        @"/bourse/list",
        @"/bourse/queryQbtBourseConfig",
        @"/bourse/queryPlatformRecycle",
        @"/bourse/getBourseOrderById",
        @"/bourse/buyBourseOrder",
        @"/bourse/queryDoneOrder",
        @"/bourse/queryPeriodListByOrderNumber",
        @"/bourse/publish",
        @"/bourse/myBourseOrderList",
        @"/bourse/revocationBourseOrder",
        @"/bourse/updateBourseOrder",
        @"/account/getAccountCapital" ,
        @"/account/getAccountOther",
        @"/product/search",
        @"/product/getProductDetail",
        @"/housing/search",
        @"/housing/getQuestionAnswer",
        @"/housing/getLastAnswer",
        @"/housing/getAnswerDetail",
        @"/housing/thumbsUp",
        @"/housing/getAllAnswer",
        @"/housing/insertQuestion",
        @"/housing/insertAnswer",
        @"/account/queryCapitalExchange",
        @"/account/capitalExchange",
        @"/account/queryTotalBill",
        @"/account/getAccountRecordDetailForBourse",
        @"/account/getAccountRecordDetailForEarnings",
        @"/account/getRecordDetailTradeOfPlatform",
        @"/account/getRecordDetailTradeOfPerson",
        @"/account/getRecordDetailForCapital",
        @"/account/getRecordDetailForWithdraw",
        @"/account/getRecordDetailForConsume",
        @"/account/getRecordDetailForCommission",
        @"/academicDegree/search",
        @"/product/getAllProductType",
        @"/region/getAllRegion",
        @"/account/myBalance",
        @"/account/withdrawConfig",
        @"/account/withdraw",
        @"/bank/list",
        @"/bank/delete",
        @"/bank/create",
        @"/account/withdrawList",
        @"/bank/bankAnthentication",
        @"/user/getPersonalInformation",
        @"/comment/getResponsiblePerson",
        @"/comment/getCommentList",
        @"/comment/getServiceRage",
        @"/comment/addComment",
        @"/comment/getSoreDetailList",
        @"/asset/disposal/search",
        @"/asset/disposal/getAssetDisposal",
        @"/asset/disposal/getDetail",
        @"/ad/list",
        @"/info/homeList",
        @"/vip/getRecentRecord",
        @"/vip/getVipType",
        @"/vip/getMembership",
        @"/vip/getVipAgreement",
        @"/vip/openOrRenew",
        @"/productFirst/queryFirstAssess",
        @"/vip/getInviteCode",
        @"/vip/payment",
        @"/vip/createVipRecord",
        @"/calculate/queryTaxesCalculation",
        @"/bank/getBankCardAgreement",
        @"/account/myWithdraw",
        @"/myQuestion/getMyAnswer",
        @"/myQuestion/getMyQuestion",
        @"/search/getSearchKey",
        @"/search/getSearchResults",
        @"/inform/list",
        @"/advancePayment/search",
        @"/setting/logoutAccount",
        @"/setting/queryQbtAboutUs",
        @"/setting/findQuestion",
        @"/setting/queryAppUpdate",
        @"/login/thirdRegister",
        @"/login/wXLoginAndRegister",
        @"/assess/insert",
        @"/assess/list",
        @"/assess/queryAssessmentCompanyById",
        @"/assess/assessnebtBuy",
        @"/assess/queryAssessmentById",
        @"/academicDegree/queryCheckDegreeNum",
        @"/academicDegree/buyCheckDegree",
        @"/assess/queryAssessmentNum",
        @"/assess/buyAssessmentNum",
        @"/user/verifyCapitalPwd",
        @"/assess/cellSearch",
        @"/academicDegree/list",
        @"/academicDegree/view",
        @"/inform/updateStatus",
        @"/inform/getStatusNotRead",
        @"/assess/queryAssessmentBuyList",
        @"/assess/queryAssessmentBuyRecordById",
        @"/productApply/queryById",
        @"/assess/getBuild",
        @"/assess/getHouse",
        @"/setting/queryLogoutConfig"];
    return tempPath;
}

- (NSString *)returnBaseUrlWithPath:(NSString *)path {
    
    NSArray *tempPath = [self urlPath];
    if ([tempPath containsObject:path]) {
        return LNewBaseUrl;
//        return BaseUrl;
    }
    return BaseUrl;
}

/**
 网络请求

 @param requestMethod 请求类型
 @param path 请求地址
 @param parameters 参数
 @param success 成功结果
 @param failure 失败结果
 */
- (void)sendRequestMethod:(HTTPMethod)requestMethod path:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(BOOL, id _Nullable))success failure:(nullable void(^) (id error))failure {
    // 请求参数
    NSMutableDictionary *mutParameters = [NSMutableDictionary dictionaryWithDictionary:[self deleteNullWithDictionary:parameters]];
    //key
    NSString *key = @"ab1a4d55a6cf90b1af1047d6f20fc82e";
    [mutParameters setValue:key forKey:@"key"];
        
    NSString *body = [Tools stringNSmutableDictionary:mutParameters];
    //将body的所有非文件类参数加keymd5一遍
    NSString *sign = [Tools MD5:[NSString stringWithFormat:@"%@",body]];
    [mutParameters setValue:sign forKey:@"sign"];
    //移除key
    [mutParameters removeObjectForKey:@"key"];
    
    // TODO: - 临时适配
    // 请求地址
//    NSString *strUrl = [NSString stringWithFormat:@"%@%@", BaseUrl, path];
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [self returnBaseUrlWithPath:path], path];

    NSURLSessionDataTask * task;
    switch (requestMethod) {
        case HTTPMethodGET:
        {
            task = [self.manager GET:strUrl parameters:mutParameters headers:@{@"usertoken":[UserManager currentUser].usertoken ?: @""} progress:^(NSProgress * _Nonnull downloadProgress) {
                           
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [SVProgressHUD dismiss];
                if (success) {
                    NSLog(@"request success 🔥🔥🔥 \n%@ \n %@", strUrl,responseObject);
                    success(YES,responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                if (error) {
                    NSLog(@"request failure 💣💣💣 \n%@ \n %@", strUrl,error);
                    failure(error);
                }
            }];
        }
            break;
        case HTTPMethodPOST:
        {
            task = [self.manager POST:strUrl parameters:mutParameters headers:@{@"usertoken":[UserManager currentUser].usertoken ?: @""} progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [SVProgressHUD dismiss];
                if (success) {
                    NSLog(@"request success 🔥🔥🔥 \n%@ \n %@", strUrl,responseObject);
                    success(YES,responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                if (error) {
                    NSLog(@"request failure 💣💣💣 \n%@ \n %@", strUrl,error);
                    failure(error);
                }
            }];
        
        }
            break;
        case HTTPMethodHEAD:
        {
            task = [self.manager HEAD:strUrl parameters:mutParameters headers:@{@"usertoken":[UserManager currentUser].usertoken ?: @""} success:^(NSURLSessionDataTask * _Nonnull task) {
                if (success) {
                    NSLog(@"request success 🔥🔥🔥 \n%@ \n %@", strUrl,task);
                    success(YES,task);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    NSLog(@"request failure 💣💣💣 \n%@ \n %@", strUrl,error);
                    failure(error);
                }
            }];
        }
            break;
            
        case HTTPMethodDELETE:
        {
            task = [self.manager DELETE:strUrl parameters:mutParameters headers:@{@"usertoken":[UserManager currentUser].usertoken ?: @""} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSLog(@"request success 🔥🔥🔥 \n%@ \n %@", strUrl,responseObject);
                    success(YES,responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    NSLog(@"request failure 💣💣💣 \n%@ \n %@", strUrl,error);
                    failure(error);
                }
            }];
        }
            break;
            
        case HTTPMethodPUT:
        {
            task = [self.manager PUT:strUrl parameters:mutParameters headers:@{@"usertoken":[UserManager currentUser].usertoken ?: @""} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [SVProgressHUD dismiss];
                if (success) {
                    NSLog(@"request success 🔥🔥🔥 \n%@ \n %@", strUrl,responseObject);
                    success(YES,responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                if (error) {
                    NSLog(@"request failure 💣💣💣 \n%@ \n %@", strUrl,error);
                    failure(error);
                }
            }];
        }
            break;

            
        default:
            break;
    }
}

/**
 网络请求

 @param requestMethod 请求类型
 @param path 请求地址
 @param parameters 参数
 @param success 成功结果
 @param failure 失败结果
 */
- (void)sendRequestMethod2:(HTTPMethod)requestMethod path:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(BOOL, id _Nullable))success failure:(nullable void(^) (id error))failure {
    // 请求参数
    NSMutableDictionary *mutParameters = [NSMutableDictionary dictionaryWithDictionary:[self deleteNullWithDictionary:parameters]];
    //key
    NSString *key = @"ab1a4d55a6cf90b1af1047d6f20fc82e";
    [mutParameters setValue:key forKey:@"key"];
    
    NSString *body = [Tools stringNSmutableDictionary:mutParameters];
    //将body的所有非文件类参数加keymd5一遍
    NSString *sign = [Tools MD5:[NSString stringWithFormat:@"%@",body]];
    [mutParameters setValue:sign forKey:@"sign"];
    //移除key
    [mutParameters removeObjectForKey:@"key"];
    
    // 请求地址
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", BaseUrl, path];
    
    NSURLSessionDataTask * task;
    switch (requestMethod) {
        case HTTPMethodGET:
        {
            task = [self.manager GET:strUrl parameters:mutParameters headers:@{@"usertoken":[UserManager currentUser].usertoken ?: @""} progress:^(NSProgress * _Nonnull downloadProgress) {
                           
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSLog(@"request success 🔥🔥🔥 \n%@ \n %@", strUrl,responseObject);
                    success(YES,responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    NSLog(@"request failure 💣💣💣 \n%@ \n %@", strUrl,error);
                    failure(error);
                }
            }];
        }
            break;
        case HTTPMethodPOST:
        {
            task = [self.manager POST:strUrl parameters:mutParameters headers:@{@"usertoken":[UserManager currentUser].usertoken ?: @""} progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSLog(@"request success 🔥🔥🔥 \n%@ \n %@", strUrl,responseObject);
                    success(YES,responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    NSLog(@"request failure 💣💣💣 \n%@ \n %@", strUrl,error);
                    failure(error);
                }
            }];
        
        }
            break;
        case HTTPMethodHEAD:
        {
            task = [self.manager HEAD:strUrl parameters:mutParameters headers:@{@"usertoken":[UserManager currentUser].usertoken ?: @""} success:^(NSURLSessionDataTask * _Nonnull task) {
                if (success) {
                    NSLog(@"request success 🔥🔥🔥 \n%@ \n %@", strUrl,task);
                    success(YES,task);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    NSLog(@"request failure 💣💣💣 \n%@ \n %@", strUrl,error);
                    failure(error);
                }
            }];
        }
            break;
            
        case HTTPMethodDELETE:
        {
            task = [self.manager DELETE:strUrl parameters:mutParameters headers:@{@"usertoken":[UserManager currentUser].usertoken ?: @""} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSLog(@"request success 🔥🔥🔥 \n%@ \n %@", strUrl,responseObject);
                    success(YES,responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    NSLog(@"request failure 💣💣💣 \n%@ \n %@", strUrl,error);
                    failure(error);
                }
            }];
        }
            break;
            
        default:
            break;
    }
}


- (void)sendPOSTRequestWithpath:(NSString *)path
                     imageArray:(NSArray *)imageArray
                        keyName:(NSString *)keyName
                         Parame:(NSDictionary *)parame
                    targetWidth:(CGFloat)width
                       progress:(void (^)(NSProgress * _Nullable))progress
                        success:(void (^)(BOOL, id _Nullable))success
                        failure:(void (^)(id _Nonnull))failure {
    // 请求参数
    NSMutableDictionary *mutParameters = [NSMutableDictionary dictionaryWithDictionary:[self deleteNullWithDictionary:parame]];
    //key
    NSString *key = @"ab1a4d55a6cf90b1af1047d6f20fc82e";
    [mutParameters setValue:key forKey:@"key"];

    NSString *body = [Tools stringNSmutableDictionary:mutParameters];
    //将body的所有非文件类参数加keymd5一遍
    NSString *sign = [Tools MD5:[NSString stringWithFormat:@"%@",body]];
    [mutParameters setValue:sign forKey:@"sign"];
    //移除key
    [mutParameters removeObjectForKey:@"key"];
    
    // 请求地址
//    NSString *strUrl = [NSString stringWithFormat:@"%@%@", BaseUrl, path];
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [self returnBaseUrlWithPath:path], path];

    [self.manager POST:strUrl parameters:mutParameters headers:@{@"usertoken":[UserManager currentUser].usertoken ?: @""} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        int i = 0 ;
        // 上传图片时，为了用户体验或是考虑到性能需要进行压缩
        for (UIImage * image in imageArray) {
            // 压缩图片，指定宽度（注释：imageCompressed：withdefineWidth：图片压缩的category）
            
            NSData * imgData = UIImageJPEGRepresentation(image, 0.1);
            // 拼接Data
            [formData appendPartWithFileData:imgData name:keyName fileName:[NSString stringWithFormat:@"picflie%d.png",i] mimeType:@"image/png"];
            i++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        CGFloat progress = uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        NSLog(@"%f",progress);
        [SVProgressHUD showProgress:progress];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"request success 🔥🔥🔥 \n%@ \n %@", strUrl,responseObject);
        if (success) {
            success(YES,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"request failure 💣💣💣 \n%@ \n %@", strUrl,error);
        if (error) {
            failure(error);
        }
    }];
}

- (void)sendPOSTRequestWithpath:(NSString *)path
                           data:(NSData *)data
                        keyName:(NSString *)keyName
                         Parame:(NSDictionary *)parame
                    targetWidth:(CGFloat)width
                       progress:(void (^)(NSProgress * _Nullable))progress
                        success:(void (^)(BOOL, id _Nullable))success
                        failure:(void (^)(id _Nonnull))failure {
    // 请求参数
    NSMutableDictionary *mutParameters = [NSMutableDictionary dictionaryWithDictionary:[self deleteNullWithDictionary:parame]];
    //key
    NSString *key = @"ab1a4d55a6cf90b1af1047d6f20fc82e";
    [mutParameters setValue:key forKey:@"key"];

    NSString *body = [Tools stringNSmutableDictionary:mutParameters];
    //将body的所有非文件类参数加keymd5一遍
    NSString *sign = [Tools MD5:[NSString stringWithFormat:@"%@",body]];
    [mutParameters setValue:sign forKey:@"sign"];
    //移除key
    [mutParameters removeObjectForKey:@"key"];
    
    // 请求地址
//    NSString *strUrl = [NSString stringWithFormat:@"%@%@", BaseUrl, path];
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", [self returnBaseUrlWithPath:path], path];

    [self.manager POST:strUrl parameters:mutParameters headers:@{@"usertoken":[UserManager currentUser].usertoken ?: @""} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDate *date = [NSDate date];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [fmt stringFromDate:date];
        [formData appendPartWithFileData:data name:keyName fileName:[NSString stringWithFormat:@"%@.mov", fileName] mimeType:@"video/quicktime"];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        CGFloat progress = uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        NSLog(@"%f",progress);
        [SVProgressHUD showProgress:progress];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"request success 🔥🔥🔥 \n%@ \n %@", strUrl,responseObject);
        if (success) {
            success(YES,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"request failure 💣💣💣 \n%@ \n %@", strUrl,error);
        if (error) {
            failure(error);
        }
    }];
}


/**
 网络请求

 @param parameters 参数
 @param success 成功结果
 @param failure 失败结果
 */
- (void)sendParameters:(NSDictionary *)parameters success:(void (^)(BOOL, id _Nullable))success failure:(nullable void(^) (id error))failure {
    // 请求参数
    NSMutableDictionary *mutParameters = [NSMutableDictionary dictionaryWithDictionary:[self deleteNullWithDictionary:parameters]];
    //key
    NSString *key = [NSString stringWithFormat:@"%d",(arc4random() % 9000000) + 1000000];
    [mutParameters setValue:key forKey:@"key"];
    //7位随机数的第3位
    NSString *key3 = [key substringWithRange:NSMakeRange(2, 1)];
    //请求接口名
    NSString *requestType = parameters[@"request_type"];
    //7位随机数的第7位
    NSString *key7 = [key substringWithRange:NSMakeRange(6, 1)];
    //APP_SECRET_KUAIJIE
    NSString *APP_SECRET_KUAIJIE = @"XOKIBwt9zdAqg7ULvbBdhIVkgtGyhiuQ";
    //7位随机数的第5位
    NSString *key5 = [key substringWithRange:NSMakeRange(4, 1)];
    //以上拼接
    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@%@",key3,requestType,key7,APP_SECRET_KUAIJIE,key5];
    //md5一遍
    NSString *makeSign = [[Tools MD5:sign] uppercaseString];
    [mutParameters setValue:makeSign forKey:@"token"];
    
    // 请求地址
    NSString *strUrl = @"https://blackblin.com/openapi/kuaijie/receiveRequest.php";
    NSURLSessionDataTask * task;
    task = [self.manager POST:strUrl parameters:mutParameters headers:@{@"usertoken":[UserManager currentUser].usertoken ?: @""} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"request success 🔥🔥🔥 \n%@ \n %@", strUrl,responseObject);
        [SVProgressHUD dismiss];
        if (success) {
            success(YES,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"request failure 💣💣💣 \n%@ \n %@", strUrl,error);
        if (error) {
            failure(error);
        }
    }];
}

- (void)downloadFileWihtURL:(NSString *)url success:(nullable NSURL * _Nonnull (^)(BOOL, id _Nullable))success completionHandler:(nonnull void (^)(void))completionHandler {
    
    NSURLSessionDownloadTask *downloadTask = [self.manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {

        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@",[response suggestedFilename]]];

    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (success) {
            success(YES,filePath);
        }
        if (completionHandler) {
            completionHandler();
        }
    }];

    [downloadTask resume];
}

- (void)sendRequestMethod:(HTTPMethod)requestMethod
                     url:(nonnull NSString *)url
               parameters:(nullable NSDictionary *)parameters
               success:(nullable void(^) (BOOL isSuccess, id _Nullable responseObject))success
                  failure:(nullable void(^) (id error))failure {

    NSURLSessionDataTask * task;
    switch (requestMethod) {
        case HTTPMethodGET:
        {
            task = [self.manager GET:url parameters:parameters headers:@{@"usertoken":[UserManager currentUser].usertoken ?: @""} progress:^(NSProgress * _Nonnull downloadProgress) {
                           
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(YES,responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    failure(error);
                }
            }];
        }
            break;
        case HTTPMethodPOST:
        {
            task = [self.manager POST:url parameters:parameters headers:@{@"usertoken":[UserManager currentUser].usertoken ?: @""} progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(YES,responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    failure(error);
                }
            }];
        
        }
            break;
        case HTTPMethodHEAD:
        {
            task = [self.manager HEAD:url parameters:parameters headers:@{@"usertoken":[UserManager currentUser].usertoken ?: @""} success:^(NSURLSessionDataTask * _Nonnull task) {
                if (success) {
                    success(YES,task);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    failure(error);
                }
            }];
        }
            break;
            
        case HTTPMethodDELETE:
        {
            task = [self.manager DELETE:url parameters:parameters headers:@{@"usertoken":[UserManager currentUser].usertoken ?: @""} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSLog(@"request success 🔥🔥🔥 \n%@ \n %@", url,responseObject);
                    success(YES,responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    NSLog(@"request failure 💣💣💣 \n%@ \n %@", url,error);
                    failure(error);
                }
            }];
        }
            break;

            
        default:
            break;
    }
}


/**
 删除字典中为空的字段
 
 @param dict 字典
 @return 字典
 */
- (NSDictionary *)deleteNullWithDictionary:(NSDictionary *)dict{
    
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] init];
    for (NSString *key in dict.allKeys) {
        if (![[dict objectForKey:key] isEqual:@""]) {
            [mutableDict setObject:[dict objectForKey:key] forKey:key];
        }
    }
    return mutableDict;
}

- (void)sd {
    
}
@end
