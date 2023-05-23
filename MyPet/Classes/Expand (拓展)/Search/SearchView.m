//
//  SearchView.m
//  Loans_Users
//
//  Created by 王健龙 on 2019/5/29.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "SearchView.h"
#import "UIColor+hexColor.h"

@interface SearchView ()
@property (nonatomic, assign) CGRect pStartFrame;
@property (nonatomic, assign) CGRect pEndFrame;
@property (nonatomic, assign) CGFloat pDistance;
@end

@implementation SearchView

- (instancetype)initWithFrame:(CGRect)frame
                  placeholder:(NSString *)placeholder
                        clikc:(nonnull void (^)(void))clikc {
    
    if (self = [super initWithFrame:frame]) {
        
        self.pStartFrame = frame;
        self.pEndFrame = CGRectMake(16+104.5+10, StatusBarHeight + 10, Screen_Width - (104.5+20+32+20), 40);
        self.pDistance = self.pStartFrame.origin.y - self.pEndFrame.origin.y;

        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.height /2 ;
        
        //提示文字
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.text = placeholder;
        placeholderLabel.textAlignment = NSTextAlignmentRight;
        placeholderLabel.textColor = [UIColor colorWithHexString:@"#7A8799"];
        placeholderLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.0f];
        [self addSubview:placeholderLabel];
        [placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.left.mas_equalTo(14);
        }];
        
        //提示图标
        UIImageView *searchImageView = [[UIImageView alloc] init];
        searchImageView.image = [UIImage imageNamed:@"new_home_searchIcon"];
        [self addSubview:searchImageView];
        [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.left.equalTo(placeholderLabel.mas_right).offset(8);
            make.right.mas_equalTo(-14);
            make.height.width.offset(16);
        }];
    
        //添加手势
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
        [[tapGestureRecognizer rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            clikc();
        }];
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

- (void)viewZoomWithContentOffset:(CGFloat)contentOffset {

    if (contentOffset <= 0) {
        self.frame = self.pStartFrame;
    }
    else if (contentOffset >= self.pDistance) {
        self.frame = self.pEndFrame;

    } else {
        CGFloat xRate = (self.pEndFrame.origin.x - self.pStartFrame.origin.x) / self.pDistance;
        CGFloat yRate = MIN((self.pStartFrame.origin.y - self.pEndFrame.origin.y) / self.pDistance, 1.0);
        CGFloat heightRate = (self.pStartFrame.size.height - self.pEndFrame.size.height) / self.pDistance;
        CGFloat widthRate = (self.pStartFrame.size.width - self.pEndFrame.size.width) / self.pDistance;
        
        self.frame = CGRectMake(self.pStartFrame.origin.x + xRate * contentOffset,
                                self.pStartFrame.origin.y - yRate * contentOffset,
                                self.pStartFrame.size.width - widthRate *contentOffset,
                                self.pStartFrame.size.height - heightRate * contentOffset);
    }
}



@end
