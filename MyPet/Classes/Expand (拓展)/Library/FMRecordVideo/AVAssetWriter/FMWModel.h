//
//  FMWModel.h
//  FMRecordVideo
//
//  Created by qianjn on 2017/3/15.
//  Copyright © 2017年 SF. All rights reserved.
//
//  Github:https://github.com/suifengqjn
//  blog:http://gcblog.github.io/
//  简书:http://www.jianshu.com/u/527ecf8c8753

#import <Foundation/Foundation.h>
#import "AVAssetWriteManager.h"

//video
//#define RECORD_MAX_TIME 30.0           //最长录制时间
#define TIMER_INTERVAL 0.05         //计时器刷新频率
#define VIDEO_FOLDER @"videoFolder" //视频录制存放文件夹

//闪光灯状态
typedef NS_ENUM(NSInteger, FMFlashState) {
    FMFlashClose = 0,
    FMFlashOpen,
    FMFlashAuto,
};

@protocol FMWModelDelegate <NSObject>

- (void)updateFlashState:(FMFlashState)state;
- (void)updateRecordingProgress:(CGFloat)progress;
- (void)updateRecordState:(FMRecordState)recordState;

@end


@interface FMWModel : NSObject

@property (nonatomic, weak  ) id<FMWModelDelegate>delegate;
@property (nonatomic, assign) FMRecordState recordState;
@property (nonatomic, strong, readonly) NSURL *videoUrl;
@property (nonatomic, assign) NSInteger RECORD_MAX_TIME;

- (instancetype)initWithFMVideoViewType:(FMVideoViewType )type superView:(UIView *)superView;

- (void)turnCameraAction;
- (void)switchflash;
- (void)startRecord;
- (void)stopRecord;
- (void)reset;


@end
