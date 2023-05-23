//
//  AppDelegate.m
//  MyPet
//
//  Created by 王健龙 on 2019/5/18.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "AppDelegate.h"

#import "BaseTabBarController.h"

#import "CycleImageView.h"
#import "OpenShareHeader.h"
#import "GenerateTestUserSig.h"
#import "PayManager.h"
#import <UMShare/UMShare.h>
#import <Bugly/Bugly.h>
#import "YZAuthID.h"
#import "HomeViewController.h"

@interface AppDelegate ()<CycleImageViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [NSThread sleepForTimeInterval:2.0];

    //Bugly
//    BuglyConfig * config = [[BuglyConfig alloc] init];
//    // 设置自定义日志上报的级别，默认不上报自定义日志
//    config.reportLogLevel = BuglyLogLevelWarn;
//    config.unexpectedTerminatingDetectionEnable = YES;
//    config.debugMode = YES;
//    config.channel = @"iOS";
//
//    [Bugly startWithAppId:@"f01a4fa234" config:config];
    
    //根控制器
    [self setUpRootViewController];
    //广告页
//    [self setUpAdvertisementView];
    
//    [self confitUShareSettings];
//    [self configUSharePlatforms];
//    [OpenShare connectWeixinWithAppId:@"wx66d5d206daaf0974"];
//    [OpenShare connectWeiboWithAppKey:@"568898243"];
//    [OpenShare connectQQWithAppId:@"101711097"];
    
//    [WXApi registerApp:@"wx66d5d206daaf0974" universalLink:@"https://gzkjaj.com/app"];
        
    return YES;
}

// 设置根控制器
- (void)setUpRootViewController {
    [self setWindow:[[UIWindow alloc] initWithFrame:SCREEN_RECT]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window setRootViewController:[[HomeViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMinimumDismissTimeInterval:1.3];
}

// 设置广告页
- (void)setUpAdvertisementView {
    UIView *advertisementView = [[UIView alloc] initWithFrame:self.window.bounds];
    advertisementView.backgroundColor = UIColor.whiteColor;
    CycleImageView *cycleImageView = [[CycleImageView alloc]initWithFrame:advertisementView.frame];
//    cycleImageView.timeInterval = 2;
    cycleImageView.canInfiniteSliding = NO;
    cycleImageView.canAutoSliding = NO;
    cycleImageView.delegate = self;
    [advertisementView addSubview:cycleImageView];

    NSDictionary *param;
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"FirstAdvertisement"] isEqual: @"FirstAdvertisement"]) {
        param = @{@"addressId":@"-1"};
    } else {
        param = @{@"addressId":@"1"};
        cycleImageView.canFingersSliding = NO;
    }
    @weakify(self)
    [[KLNetworking shareManager] sendRequestMethod:HTTPMethodGET path:@"/ad/list" parameters:param success:^(BOOL isSuccess, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == NewRequestSuccess) {
            NSMutableArray *imageUrlArray = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"data"]) {
                [imageUrlArray addObject:dic[@"picture"]];
            }
            if (imageUrlArray.count == 0) {
                cycleImageView.images = @[@"placeholder"];
            } else {
                cycleImageView.images = imageUrlArray;
            }
        } else {
            cycleImageView.images = @[@"placeholder"];
            [Tools handleServerStatusCodeDictionary:responseObject];
        }
        
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"FirstAdvertisement"] isEqual: @"FirstAdvertisement"]) {
            //首次打开
            [[RACScheduler mainThreadScheduler] afterDelay:5 schedule:^{
                [advertisementView removeFromSuperview];
                @strongify(self)
                [[NSUserDefaults standardUserDefaults] setObject:@"FirstAdvertisement" forKey:@"FirstAdvertisement"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [advertisementView removeFromSuperview];
//                [self findPrivacyPolicy];
            }];

            cycleImageView.didSelectItemBlock = ^(NSInteger index) {
                if (index == cycleImageView.images.count - 1) {
                    @strongify(self)
                    [[NSUserDefaults standardUserDefaults] setObject:@"FirstAdvertisement" forKey:@"FirstAdvertisement"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [advertisementView removeFromSuperview];
//                    [self findPrivacyPolicy];
                }
            };
        } else {
            //非首次打开
            [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
                [advertisementView removeFromSuperview];
//                [self findPrivacyPolicy];
            }];
        }

    } failure:^(id  _Nonnull error) {
        [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
            [advertisementView removeFromSuperview];
//            [self findPrivacyPolicy];
        }];
    }];
    
    [self.window addSubview:advertisementView];
}

//- (void)findPrivacyPolicy {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"findPrivacyPolicy"] isEqual: @"findPrivacyPolicy"]) {
//            FindPrivacyPolicyView *policyview = [[FindPrivacyPolicyView alloc] init];
//            policyview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//            [KeyWindow addSubview:policyview];
//        }
//    });
//}


#pragma mark - 分享
- (void)confitUShareSettings {
    //配置微信平台的Universal Links
    //微信和QQ完整版会校验合法的universalLink，不设置会在初始化平台失败
    [UMSocialGlobal shareInstance].universalLinkDic = @{@(UMSocialPlatformType_WechatSession):@"https://umplus-sdk-download.oss-cn-shanghai.aliyuncs.com/",
    @(UMSocialPlatformType_QQ):@"https://umplus-sdk-download.oss-cn-shanghai.aliyuncs.com/qq_conn/101711097"
    };
}

- (void)configUSharePlatforms {
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"101711097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"568898243"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

// 弹出登录页面
- (void)loginViewController {
    [Tools handleServerStatusCodeDictionary:@{@"code":@"-1",@"msg":@"你的账号于另一台手机上登录"}];
}
 

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"inactive" object:nil];
}



- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSLog(@"从哪个app跳转而来 Bundle ID: %@", options[UIApplicationOpenURLOptionsSourceApplicationKey]);
    NSLog(@"URL scheme:%@", [url scheme]);
    NSLog(@"URL query:%@", [url query]);
    
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
        [PayManager handleOpenURL:url delegate:[PayManager sharedManager]];
    }
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
