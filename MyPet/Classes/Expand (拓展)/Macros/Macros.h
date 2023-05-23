//
//  Macros.h
//  Tools
//
//  Created by 王健龙 on 2019/3/15.
//  Copyright © 2019 王健龙. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define FSWindow [UIApplication sharedApplication].delegate.window

// 颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

// 颜色RGB
#define XYQColor(r, g, b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define XYQColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
// 随机色
#define XYQRandomColor  XYQColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


#define color_TabBar_Color   RGBA(47, 155, 254, 1) //菜单栏颜色
#define color_Text_Color     RGBA(170, 170, 170, 1) //浅文本色
#define color_Text2_Color    RGBA(175, 175, 175, 1) //浅文本色
#define color_Line_Color     RGBA(246,246,246, 1) //线条背景色

#define color_Main_Color   RGBA(47, 155, 254, 1) //主色
#define color_Sub_Color    RGBA(255, 88, 57, 1) //副色

#define color_252    RGBA(252, 252, 252, 1) //部分背景颜色
#define color_228    RGBA(228,228,228, 1) //线条背景色
#define color_153    RGBA(153,153,153, 1) //副文本
#define color_102    RGBA(102,102,102, 1) //线条背景色
#define color_51     RGBA(51,51,51, 1) //标题色


#define color_white        RGBA(255, 255, 255, 1) //白色
#define color_white_252    RGBA(252, 252, 252, 1) //白色

#define Screen_Width        [UIScreen mainScreen].bounds.size.width
#define Screen_Height       [UIScreen mainScreen].bounds.size.height
#define Is_Iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define Is_IPhoneX (Screen_Width >=375.0f && Screen_Height >=812.0f && Is_Iphone)

#define ScaleW(width)  width*Screen_Width/375
#define scaleH(value) (((value) * [UIScreen mainScreen].bounds.size.height) / 1334.0)

#define StatusBar_Height    (Is_IPhoneX ? (44.0):(20.0))
#define TabBar_Height       (Is_IPhoneX ? (49.0 + 34.0):(49.0))
#define NavBar_Height       (44)
#define SearchBar_Height    (55)
#define Bottom_SafeHeight   (Is_IPhoneX ? (34.0):(10))

//StatusBar
#ifndef StatusBarHeight
#define StatusBarHeight    ([UIApplication sharedApplication].statusBarFrame.size.height)
#endif

// 屏幕尺寸
#define SCREEN_RECT ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// 状态栏、导航栏的尺寸
#define STATUS_RECT ([[UIApplication sharedApplication] statusBarFrame])
#define NAV_RECT (self.navigationController.navigationBar.bounds)
#define NAV_HEIGHT (IS_IPHONE_X ? 88.f:64.f)
#define BottomSafeAreaHeight (IS_IPHONE_X ? 34 : 10)
#define TabBarHeight 49

#define IS_IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

#define weakSelf(type)    __weak   typeof(type) weak##type = type;
#define KeyWindow [UIApplication sharedApplication].keyWindow
#define RequestSuccess (1)
#define NewRequestSuccess (200)
#endif /* Macros_h */
