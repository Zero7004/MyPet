//
//  FMWVideoView.m
//  FMRecordVideo
//
//  Created by qianjn on 2017/3/15.
//  Copyright © 2017年 SF. All rights reserved.
//
//  Github:https://github.com/suifengqjn
//  blog:http://gcblog.github.io/
//  简书:http://www.jianshu.com/u/527ecf8c8753

#import "FMWVideoView.h"
#import "FMRecordProgressView.h"
#import "UIColor+Hex.h"


@interface FMWVideoView ()<FMWModelDelegate>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView *timeView;
@property (nonatomic, strong) UILabel *timelabel;
@property (nonatomic, strong) UIButton *turnCamera;
@property (nonatomic, strong) UIButton *flashBtn;
@property (nonatomic, strong) FMRecordProgressView *progressView;
@property (nonatomic, strong) UIButton *recordBtn;
@property (nonatomic, strong) UIView *recordBGView;
@property (nonatomic, assign) CGFloat recordTime;
@property (nonatomic, strong) UILabel *statelabel;

@property (nonatomic, strong, readwrite) FMWModel *fmodel;

@end

@implementation FMWVideoView

- (instancetype)initWithFMVideoViewType:(FMVideoViewType)type withReadTime:(NSInteger)readTime {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self BuildUIWithType:type withReadTime:readTime];
    }
    return self;
}


#pragma mark - view
- (void)BuildUIWithType:(FMVideoViewType)type withReadTime:(NSInteger)readTime {
    self.fmodel = [[FMWModel alloc] initWithFMVideoViewType:type superView:self];
    self.fmodel.RECORD_MAX_TIME = readTime;
    self.fmodel.delegate = self;
        
    self.timeView = [[UIView alloc] init];
    self.timeView.hidden = YES;
    self.timeView.frame = CGRectMake((Screen_Width - 100)/2, 16, 100, 34);
    self.timeView.backgroundColor = [UIColor colorWithRGB:0x242424 alpha:0.7];
    self.timeView.layer.cornerRadius = 4;
    self.timeView.layer.masksToBounds = YES;
    [self addSubview:self.timeView];
    
    UIView *redPoint = [[UIView alloc] init];
    redPoint.frame = CGRectMake(0, 0, 6, 6);
    redPoint.layer.cornerRadius = 3;
    redPoint.layer.masksToBounds = YES;
    redPoint.center = CGPointMake(25, 17);
    redPoint.backgroundColor = [UIColor redColor];
    [self.timeView addSubview:redPoint];
    
    self.timelabel =[[UILabel alloc] init];
    self.timelabel.font = [UIFont systemFontOfSize:13];
    self.timelabel.textColor = [UIColor whiteColor];
    self.timelabel.frame = CGRectMake(40, 8, 40, 28);
    [self.timeView addSubview:self.timelabel];
    
    CGRect rect = CGRectZero;
    switch (type) {
        case Type1X1:
            rect = CGRectMake((Screen_Width - 58)/2, (Screen_Width - (39*2)) + 38.5, 58, 58);
            break;
        case Type4X3:
            rect = CGRectMake((Screen_Width - 58)/2, (Screen_Width - (39*2)) * 4/3 + 38.5, 58, 58);
            break;
        case TypeFullScreen:
            rect = [UIScreen mainScreen].bounds;
            break;
        default:
            rect = [UIScreen mainScreen].bounds;
            break;
    }
//    self.progressView = [[FMRecordProgressView alloc] initWithFrame:CGRectMake((Screen_Width - 58)/2, Screen_Height - Bottom_SafeHeight - 63 - 58, 58, 58)];
    self.progressView = [[FMRecordProgressView alloc] initWithFrame:rect];
    self.progressView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.progressView];
    
    self.recordBGView = [UIView new];
    self.recordBGView.backgroundColor = [UIColor colorWithHexString:@"#FE5B4C"];
    self.recordBGView.frame = CGRectMake(4, 4, 50, 50);
    self.recordBGView.layer.cornerRadius = 25;
    self.recordBGView.layer.masksToBounds = YES;
    [self.progressView addSubview:self.recordBGView];

    self.recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.recordBtn addTarget:self action:@selector(startRecord) forControlEvents:UIControlEventTouchUpInside];
    self.recordBtn.frame = CGRectMake(4, 4, 50, 50);
//    self.recordBtn.backgroundColor = [UIColor colorWithHexString:@"#FE5B4C"];
//    self.recordBtn.layer.cornerRadius = 25;
//    self.recordBtn.layer.masksToBounds = YES;
    [self.progressView addSubview:self.recordBtn];
    [self.progressView resetProgress];
    
    self.statelabel = [[UILabel alloc] init];
    self.statelabel.text = @"点击开始录制";
    self.statelabel.textColor = [UIColor colorWithHexString:@"#7A8799"];
    self.statelabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14.0f];
//    self.statelabel.frame = CGRectMake(40, 8, 40, 28);
    [self addSubview:self.statelabel];
    [self.statelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.top.equalTo(self.progressView.mas_bottom).offset(20);
    }];

}

- (void)updateViewWithRecording
{
    self.timeView.hidden = NO;
    self.topView.hidden = YES;
    [self changeToRecordStyle];
    self.statelabel.text = @"录制中···";
}

- (void)updateViewWithStop
{
    self.timeView.hidden = YES;
    self.topView.hidden = NO;
    [self changeToStopStyle];
    self.statelabel.text = @"录制完成";
}

- (void)updateViewWithReState
{
    self.timeView.hidden = YES;
    self.topView.hidden = NO;
    [self changeToReStateStyle];
    self.statelabel.text = @"点击开始录制";
}


- (void)changeToRecordStyle
{
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint center = self.recordBGView.center;
        CGRect rect = self.recordBGView.frame;
        rect.size = CGSizeMake(28, 28);
        self.recordBGView.frame = rect;
        self.recordBGView.layer.cornerRadius = 4;
        self.recordBGView.center = center;
    }];
}

- (void)changeToStopStyle
{
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint center = self.recordBGView.center;
        CGRect rect = self.recordBGView.frame;
        rect.size = CGSizeMake(11, 11);
        self.recordBGView.frame = rect;
        self.recordBGView.layer.cornerRadius = 11/2;
        self.recordBGView.center = center;
    }];
}

- (void)changeToReStateStyle
{
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint center = self.recordBGView.center;
        CGRect rect = self.recordBGView.frame;
        rect.size = CGSizeMake(50, 50);
        self.recordBGView.frame = rect;
        self.recordBGView.layer.cornerRadius = 25;
        self.recordBGView.center = center;
    }];
}

#pragma mark - action

- (void)dismissVC
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismissVC)]) {
        [self.delegate dismissVC];
    }
}

- (void)turnCameraAction
{
    [self.fmodel turnCameraAction];
}

- (void)flashAction
{
    [self.fmodel switchflash];
}

- (void)startRecord
{
    if (self.fmodel.recordState == FMRecordStateInit) {
        [self.fmodel startRecord];
    } else if (self.fmodel.recordState == FMRecordStateRecording) {
        [self.fmodel stopRecord];
    } else {
        [self.fmodel reset];
    }
    
}


- (void)stopRecord
{
     [self.fmodel stopRecord];
}

- (void)reset
{
    [self.fmodel reset];
}

#pragma mark - FMFModelDelegate


- (void)updateRecordState:(FMRecordState)recordState
{
    if (recordState == FMRecordStateInit) {
        [self updateViewWithReState];
        [self.progressView resetProgress];
    } else if (recordState == FMRecordStateRecording) {
        [self updateViewWithRecording];
    } else  if (recordState == FMRecordStateFinish) {
        [self updateViewWithStop];
        if (self.delegate && [self.delegate respondsToSelector:@selector(recordFinishWithvideoUrl:)]) {
            [self.delegate recordFinishWithvideoUrl:self.fmodel.videoUrl];
        }
    }
}

- (void)updateRecordingProgress:(CGFloat)progress
{
    [self.progressView updateProgressWithValue:progress];
    self.timelabel.text = [self changeToVideotime:progress * self.fmodel.RECORD_MAX_TIME];
    [self.timelabel sizeToFit];
}

- (NSString *)changeToVideotime:(CGFloat)videocurrent {
    
    return [NSString stringWithFormat:@"%02li:%02li",lround(floor(videocurrent/60.f)),lround(floor(videocurrent/1.f))%60];
    
}

@end
