//
//  SaveImageView.m
//  MyPet
//
//  Created by 王健龙 on 2020/4/23.
//  Copyright © 2020 王健龙. All rights reserved.
//

#import "SaveImageView.h"

#import <Photos/PHAssetChangeRequest.h>

@interface SaveImageView ()

@end

@implementation SaveImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        //设置蒙版
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        [self initUI];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    _image = image;
}

#pragma mark - 初始化视图
- (void)initUI {
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = UIColor.clearColor;
    backgroundView.frame = self.bounds;
    [self addSubview:backgroundView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        [self hide];
    }];
    [backgroundView addGestureRecognizer:tap];
    
    [self createAlertView];
}

/// 创建警告视图
- (void)createAlertView {
    UIView *alertView = [[UIView alloc] init];
    alertView.backgroundColor = color_white;
    alertView.layer.masksToBounds = YES;
    alertView.layer.cornerRadius = 5;
    [self addSubview:alertView];
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(242);
        make.height.mas_equalTo(125);
    }];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:18.0];
    titleLabel.text = @"是否保存图片至相册？";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = RGB(26, 26, 26);
    [alertView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(25);
    }];
    
    // 取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.layer.borderColor = color_Sub_Color.CGColor;
    cancelButton.layer.borderWidth = 1;
    cancelButton.layer.cornerRadius = 2;
    cancelButton.layer.masksToBounds = YES;
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:color_Sub_Color forState:UIControlStateNormal];
    [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self hide];
    }];
    [alertView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(81);
        make.left.mas_equalTo(50);
        make.width.mas_equalTo(56);
        make.height.mas_equalTo(20);
    }];
    
    // 保存按钮
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.backgroundColor = color_Sub_Color;
    saveButton.layer.cornerRadius = 2;
    saveButton.layer.masksToBounds = YES;
    saveButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:color_white forState:UIControlStateNormal];
    [[saveButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self loadImageFinished:self.image];
    }];
    [alertView addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cancelButton.mas_top);
        make.left.mas_equalTo(cancelButton.mas_right).mas_offset(29);
        make.width.mas_equalTo(56);
        make.height.mas_equalTo(20);
    }];
}

/// 创建保存成功视图
- (void)createSaveSuccessView {
    UIView *successView = [[UIView alloc] init];
    successView.backgroundColor = color_white;
    successView.layer.masksToBounds = YES;
    successView.layer.cornerRadius = 5;
    [self addSubview:successView];
    [successView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(242);
        make.height.mas_equalTo(187);
    }];
    
    // 图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"mine_save_success"];
    [successView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24);
        make.left.mas_equalTo(72);
        make.width.height.mas_equalTo(98);
    }];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:18.0];
    titleLabel.text = @"保存成功";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = RGB(26, 26, 26);
    [successView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(16);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(25);
    }];
}

/// 移除
- (void)hide {
    [self removeFromSuperview];
}

/// 图片保存在本地
/// @param image 图片
- (void)loadImageFinished:(UIImage *)image {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
         //写入图片到相册
         PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
     } completionHandler:^(BOOL success, NSError * _Nullable error) {
         NSLog(@"success = %d, error = %@", success, error);
         if (success) {
             [[RACScheduler mainThreadScheduler] schedule:^{
                 [self createSaveSuccessView];
             }];
             [[RACScheduler mainThreadScheduler] afterDelay:1.5 schedule:^{
                 [self hide];
             }];
         }
         if (error) {
             [self hide];
             [SVProgressHUD showErrorWithStatus:@"保存失败"];
         }
    }];
}
@end
