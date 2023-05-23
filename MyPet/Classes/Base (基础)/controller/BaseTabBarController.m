//
//  BaseTabBarController.m
//  tool
//
//  Created by 王健龙 on 2019/3/15.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "BaseViewController.h"
#import "HomeViewController.h"
#import "BusinessViewController.h"
#import "EarningsViewController.h"
#import "MineViewController.h"

#import "Tools.h"

@interface BaseTabBarController ()

@property (nonatomic, assign) NSInteger lastItem;
@property (nonatomic, assign) NSInteger currentItem;

@property (nonatomic, strong) NSMutableArray *ItemNames;

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpChildViewController];
}

// 设置控制器
- (void)setUpChildViewController {
    
    BaseNavigationController *homeNav = [self addChildViewController:[HomeViewController new] title:@"首页" image:@"home_dark" selImage:@"home_light"];
        
    BaseNavigationController *dynamicNav = [self addChildViewController:[BusinessViewController new] title:@"业务" image:@"alerts_dark" selImage:@"alerts_light"];
    
    BaseNavigationController *tradingNav = [self addChildViewController:[[EarningsViewController alloc] init] title:@"收益" image:@"trading_dark" selImage:@"trading_light"];
    
    BaseNavigationController *mineNav = [self addChildViewController:[MineViewController new] title:@"我的" image:@"my_dark" selImage:@"my_light"];
    
    self.viewControllers = @[homeNav,dynamicNav,tradingNav,mineNav];
    [self.ItemNames addObjectsFromArray:@[@"首页", @"业务", @"收益", @"我的"]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color_TabBar_Color, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color_Text_Color, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
}


/**
 添加子控制器

 @param childVC 子控制器
 @param title 标题
 @param image 普通图片
 @param selImage 选中图片
 @return 导航控制器
 */
- (BaseNavigationController *)addChildViewController:(BaseViewController *)childVC title:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage {
    childVC.title = title;
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
    return nav;
}


/**
 点击动画

 @param hidden 是否显示
 */
- (void)hideTabbar:(BOOL)hidden {
    [UIView animateWithDuration:.3f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.tabBar.top = SCREEN_HEIGHT - (hidden == YES ? 0 : BottomSafeAreaHeight);
    } completion:nil];
}


/**
 点击事件
 
 */

- (NSInteger)getLastItemIndex {
    return self.lastItem;
}

- (void)setLastItemIndex:(NSInteger)index {
    self.lastItem = index;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {

}


- (NSMutableArray *)ItemNames {
    if (!_ItemNames) {
        _ItemNames = [NSMutableArray new];
    }
    return _ItemNames;
}

@end
