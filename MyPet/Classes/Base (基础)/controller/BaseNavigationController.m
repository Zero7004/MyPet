//
//  BaseNavigationController.m
//  tool
//
//  Created by 王健龙 on 2019/3/15.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.translucent = NO;
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //去掉阴影分割线
//    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.barTintColor = RGBA(255, 255, 255, 1);
    
    // 设置导航默认标题的颜色及字体大小
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:RGBA(35, 24, 21, 1), NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:18.5]};
    
    self.navigationBar.backIndicatorImage = [[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"nav_back"];
    
    if (@available(iOS 11.0, *)){
        self.navigationBar.prefersLargeTitles = NO;
    }
    
}

#pragma mark - 重写push方法,使推出的控制器隐藏tabbar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        
        //隐藏标签栏
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [super pushViewController:viewController animated:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
