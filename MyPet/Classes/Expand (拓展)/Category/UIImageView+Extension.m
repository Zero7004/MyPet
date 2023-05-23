//
//  UIImageView+Extension.m
//  Tools
//
//  Created by 王健龙 on 2019/3/24.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "UIImage+Extension.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (Extension)

- (void)setCircleHeaderUrl:(NSString *)url {
    [self sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[[UIImage imageNamed:@"mine_icon"] circleImage] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return ;
        self.image = [image circleImage];
    }];
}

- (void)setCirclHeaderUrl:(NSString *)url withplaceholderImageName:(NSString *)placeholderImageName {
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholderImageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        self.image = [image circleImage];
    }];
}

- (void)setImageUrl:(NSString *)url {
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageAllowInvalidSSLCertificates completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        self.image = image;
    }];
}

- (void)setImageUrl:(NSString *)url withplaceholderImageName:(NSString *)placeholderImageName {
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholderImageName] options:SDWebImageAllowInvalidSSLCertificates completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        self.image = image;
    }];
}


@end
