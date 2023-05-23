//
//  KLPhotoBrowse.h
//  RedPacket
//
//  Created by lzf on 2018/9/6.
//  Copyright © 2018 lzf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLPhotoZoom.h"

@interface KLPhotoBrowse : UIView

/// 图片URL数组
@property (nonatomic, strong) NSMutableArray * urlArray;
/// 图片路径数组
@property (nonatomic, strong) NSMutableArray * pathArray;
/// 图片名称数组
@property (nonatomic, strong) NSMutableArray * nameArray;

/// 当前图片索引
@property (nonatomic, assign) NSInteger currentIndex;

/// 当前显示的图片
@property (nonatomic, strong) KLPhotoZoom * currentPhotoZoom;

/// 设定图片能否支持所有手势操作
@property(nonatomic) BOOL gesturesEnabled;
/// 设定图片能否支持用户缩放(双击)
@property(nonatomic, getter=isZoomEnabledWithTap) BOOL zoomEnabledWithTap;
/// 设定图片能否支持用户长按保存
@property(nonatomic, getter=isScrollEnabled) BOOL longEnabled;

@end
