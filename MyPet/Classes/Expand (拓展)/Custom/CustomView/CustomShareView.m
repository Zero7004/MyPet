//
//  CustomShareView.m
//  MyPet
//
//  Created by long on 2021/7/27.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "CustomShareView.h"
#import "UIButton+LXMImagePosition.h"
#import "UIColor+hexColor.h"

@interface CustomShareView ()
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *iconArray;
@property (nonatomic, strong) NSMutableArray *btnArray;
@end

@implementation CustomShareView

- (instancetype)init{
    
    self = [super init];
    if (self){
        [self initData];
        [self initView];
    }
    return self;
}

- (void)initData {
    self.titleArray = @[@"微信好友", @"朋友圈", @"微信群", @"保存图片"];
    self.iconArray = @[@"ps_wechat", @"ps_wechatF", @"ps_wechatS", @"ps_down"];
}

- (void)initView {
    self.backgroundColor = color_white;
    // 阴影颜色
     self.layer.shadowColor = [UIColor blackColor].CGColor;
     // 阴影偏移，默认(0, -3)
    self.layer.shadowOffset = CGSizeMake(-5,-5);
     // 阴影透明度，默认0
    self.layer.shadowOpacity = 0.1;
     // 阴影半径，默认3
    self.layer.shadowRadius = 5;
    
    [self.titleArray enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:self.iconArray[idx]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#A1A8B3"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0f];
        [btn setImagePosition:LXMImagePositionTop spacing:2];
        [self addSubview:btn];
        [self.btnArray addObject:btn];
        @weakify(self);
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.ShareBlock) {
                CustomShareType type;
                switch (idx) {
                    case 1:
                        type = CustomShareType_Circle;
                        break;
                    case 2:
                        type = CustomShareType_group;
                        break;
                    case 3:
                        type = CustomShareType_down;
                        break;
                    default:
                        type = CustomShareType_wechat;
                        break;
                }
                self.ShareBlock(type);
            }
        }];
    }];
    
    [self.btnArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24 leadSpacing:40 tailSpacing:40];
    [self.btnArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(16);
        make.height.offset(66);
    }];
}

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray new];
    }
    return _btnArray;
}

@end
