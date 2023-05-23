//
//  KLPhotoZoom.h
//  RedPacket
//
//  Created by lzf on 2018/9/6.
//  Copyright © 2018 lzf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLPhotoZoom : UIScrollView

@property (nonatomic, strong) UIImageView * imageView;

//默认是屏幕的宽和高
@property (assign, nonatomic) CGFloat imageNormalWidth; // 图片未缩放时宽度
@property (assign, nonatomic) CGFloat imageNormalHeight; // 图片未缩放时高度


//重置回原样
- (void)resetUI;


//缩放方法，共外界调用
- (void)pictureZoomWithScale:(CGFloat)zoomScale;

@end
