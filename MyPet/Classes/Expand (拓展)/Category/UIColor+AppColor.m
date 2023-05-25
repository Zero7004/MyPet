//
//  UIColor+AppColor.m
//  Main2020_iOS_DEV
//
//  Created by Calvin Tse on 2020/6/1.
//  Copyright © 2020 formssi. All rights reserved.
//

#import "UIColor+AppColor.h"

@implementation UIColor (AppColor)

#pragma mark - red

#pragma mark - black
+ (instancetype)black01 {
    if (@available(iOS 11.0, *)) {
        return [self colorNamed:NSStringFromSelector(_cmd) inBundle:[self resourceBundle] compatibleWithTraitCollection:nil];
    } else {
        return nil;
    }
}

+ (instancetype)black02 {
    if (@available(iOS 11.0, *)) {
        return [self colorNamed:NSStringFromSelector(_cmd) inBundle:[self resourceBundle] compatibleWithTraitCollection:nil];
    } else {
        return nil;
    }
}

#pragma mark - blue
+ (instancetype)blue01 {
    if (@available(iOS 11.0, *)) {
        return [self colorNamed:NSStringFromSelector(_cmd) inBundle:[self resourceBundle] compatibleWithTraitCollection:nil];
    } else {
        return nil;
    }
}

#pragma mark - orange


#pragma mark - yellow
+ (instancetype)yellow01 {
    if (@available(iOS 11.0, *)) {
        return [self colorNamed:NSStringFromSelector(_cmd) inBundle:[self resourceBundle] compatibleWithTraitCollection:nil];
    } else {
        return nil;
    }
}

#pragma mark - grape

#pragma mark - cyan


#pragma mark - private method
+ (NSBundle *)resourceBundle {
    NSBundle *bundle = [NSBundle mainBundle];
//    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"FSServiceModule")];
//    NSURL *bundleURL = [bundle URLForResource:@"FSServiceModule" withExtension:@"bundle"];
//    NSBundle *resourceBundle = bundleURL ? [NSBundle bundleWithURL: bundleURL] : bundle;
    return bundle;
}

@end
