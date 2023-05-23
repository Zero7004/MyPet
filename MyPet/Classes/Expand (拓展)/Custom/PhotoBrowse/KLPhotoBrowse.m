//
//  KLPhotoBrowse.m
//  RedPacket
//
//  Created by lzf on 2018/9/6.
//  Copyright © 2018 lzf. All rights reserved.
//

#import "KLPhotoBrowse.h"
#import "UIImageView+Extension.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface KLPhotoBrowse () <UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger count;

/// 数组
@property (nonatomic, strong) NSMutableArray * imageArray;

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UILabel * indexLabel;

/////
//@property (nonatomic, strong)RPAlertView *alertView;
@end

@implementation KLPhotoBrowse

- (id)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        
        self.longEnabled = YES;
        self.zoomEnabledWithTap = YES;
        
        [self addGestureRecognizer];
        
        [self addSubview:self.scrollView];
        
        [self addSubview:self.indexLabel];
        
    }
    return self;
    
}

//- (RPAlertView *)alertView {
//    if (!_alertView) {
//        _alertView = [[RPAlertView alloc] init];
//    }
//    return _alertView;
//}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.pagingEnabled = YES;
    }
    
    return _scrollView;
}

- (UILabel *)indexLabel {
    
    if (!_indexLabel) {
        
        _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /2 - 20, SCREEN_HEIGHT - 50, 40, 20)];
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _indexLabel;
}


- (void)addGestureRecognizer {
    
    self.userInteractionEnabled = YES;
    
    //单击移除
    UITapGestureRecognizer * singlTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singlTapGR)];
    singlTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singlTap];
    
    
//    if (self.zoomEnabledWithTap) {
//        UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGR:)];
//        doubleTap.numberOfTapsRequired = 2;
//        [self addGestureRecognizer:doubleTap];
//
//        //解决单击双击冲突
//        [singlTap requireGestureRecognizerToFail:doubleTap];
//    }
    
    if (self.longEnabled) {
        UILongPressGestureRecognizer * longGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGR:)];
        [self addGestureRecognizer:longGR];
    }
    
}

#pragma mark 手势
- (void)singlTapGR {
    [self removeFromSuperview];
}

- (void)doubleTapGR:(UITapGestureRecognizer *)tap {
    if (self.currentPhotoZoom.imageView.frame.size.width > SCREEN_WIDTH) {
        [self.currentPhotoZoom resetUI];
    } else {
        [self.currentPhotoZoom pictureZoomWithScale:1.5];
    }
    
}

- (void)longGR:(UILongPressGestureRecognizer *)longGR {
    if (longGR.state == UIGestureRecognizerStateBegan) {
//        [self.alertView initWihtAlertTitle:@[@"保存到相册",@"取消"] SelectedBtn:^(NSInteger selectedTag) {
//            if (selectedTag ==  0) {
//                NSData * imgData = UIImageJPEGRepresentation(self.currentPhotoZoom.imageView.image, 1);
//                ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//                [library writeImageDataToSavedPhotosAlbum:imgData metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
//                    if ([assetURL path].length > 0) {
//                        [MBProgressHUD showSuccess:@"保存成功"];
//                    }else{
//                        [MBProgressHUD showError:@"保存失败"];
//                    }
//                }];
//            }
//        }];
    }
    
}

#pragma makr 设置图片
- (void)setUrlArray:(NSMutableArray *)urlArray {
    _urlArray = urlArray;
    
    self.imageArray = _urlArray;
    [self setUpImageView:_urlArray];
}

- (void)setPathArray:(NSMutableArray *)pathArray {
    _pathArray = pathArray;
    
    self.imageArray = _pathArray;
    [self setUpImageView:_pathArray];
}

- (void)setNameArray:(NSMutableArray *)nameArray {
    _nameArray = nameArray;
    
    self.imageArray = _nameArray;
    [self setUpImageView:_nameArray];
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    
}

- (void)setZoomEnabledWithTap:(BOOL)zoomEnabledWithTap {
    _zoomEnabledWithTap = zoomEnabledWithTap;
}

- (void)setLongEnabled:(BOOL)longEnabled {
    _longEnabled = longEnabled;
}

- (void)setUpImageView:(NSMutableArray *)imageArray {
    
    self.count = imageArray.count;
    
    for (KLPhotoZoom *photoZoom in self.scrollView.subviews) {
        [photoZoom removeFromSuperview];
    }
    
    self.scrollView.contentSize = CGSizeMake(imageArray.count * self.frame.size.width, self.frame.size.height);
    
    for (int i = 0; i < imageArray.count; i ++) {
        
        KLPhotoZoom *photoZoomView = [[KLPhotoZoom alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        photoZoomView.imageNormalWidth = SCREEN_WIDTH;
        photoZoomView.imageNormalHeight = SCREEN_HEIGHT;
        photoZoomView.backgroundColor = [UIColor blackColor];
        
        if (imageArray == _urlArray) {
            [photoZoomView.imageView setImageUrl:imageArray[i]];
        } else if (imageArray == _pathArray) {
            [photoZoomView.imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:imageArray[i]]]];
        } else {
            [photoZoomView.imageView setImage:[UIImage imageNamed:imageArray[i]]];
        }
        
        [self.scrollView addSubview:photoZoomView];
    }
   
    self.indexLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.currentIndex + 1,imageArray.count];
    self.currentPhotoZoom = self.scrollView.subviews[self.currentIndex];
    self.scrollView.contentOffset = CGPointMake(self.currentIndex * self.frame.size.width, 0);
}


#pragma mark scroll代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if (index != self.currentIndex) {
        KLPhotoZoom *photoZoomView = scrollView.subviews[self.currentIndex];
        [photoZoomView pictureZoomWithScale:1.0];
        
        self.currentIndex = index;
        self.currentPhotoZoom = scrollView.subviews[self.currentIndex];
    }
    
    self.indexLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.currentIndex + 1,self.count];
}


@end
