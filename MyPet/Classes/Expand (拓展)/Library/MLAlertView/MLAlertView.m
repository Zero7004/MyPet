//
//  MLAlertView.m
//  AlertView
//
//  Created by Admin on 2018/6/6.
//  Copyright © 2018年 mlb. All rights reserved.
//

#import "MLAlertView.h"
#import "UIView+MLExtension.h"
#import "NSString+AttributedString.h"
#import "UIColor+hexColor.h"

typedef void(^FinishBlock)(NSInteger index);

@interface MLAlertView ()

/** 选中按钮之后的回调block */
@property (nonatomic,   copy) FinishBlock finishBlock;

/** bgView */
@property (nonatomic, strong) UIView * maskView;

/** 最顶上的titleLabel */
@property (nonatomic, strong) UILabel * titleLabel;

/** 副标题或描述 */
@property (nonatomic, strong) UILabel * messageLabel;

/** 副标题或描述的Alignment */
@property (nonatomic, assign) NSTextAlignment messageAlignment;

/** 副标题或描述的部分字体颜色 */
@property (nonatomic, assign) NSRange range;

/** 横线 */
@property (nonatomic, strong) UIView * lineView;

/** 接收装按钮文字数组的 */
@property (nonatomic, strong) NSArray * itemArr;

/** 接收传进来的titleString */
@property (nonatomic,   copy) NSString * titleString;

/** 接收传进来的messageString */
@property (nonatomic,   copy) NSString * messageString;

/** 装竖线的数组 */
@property (nonatomic, strong) NSMutableArray<UIView *> * btnLineArr;

/** 按钮数组 */
@property (nonatomic, strong) NSMutableArray<UIButton *> * buttonArr;

@end

@implementation MLAlertView
{
    /** 这里是可修改的一些基本属性 */
    
    CGFloat viewWith;//自身弹出alertView的宽度 屏幕宽*（0.5~0.9之间最佳）
    
    CGFloat viewTop;//title距离顶部的距离 适当调
    
    CGFloat viewLeftRight;//副标题或描述距离左右的距离 适当调
    
    CGFloat messageLabelFont;//副标题或描述的字体大小
    
    CGFloat messageLineSpace;//副标题或描述多行情况下上下两行间的行距 适当调
    
    CGFloat msgAndLineViewSpace;//副标题或描述与横线之间的距离 大于0 适当调
    
    CGFloat titleHeight;//titleLabel最顶上大标题占的高度 适当调
    
    CGFloat btnHeight;//底部按钮item占的高度 适当调
    
    CGFloat bgViewAlpha;//自身背景灰色的alpha 0~1 越大越灰
    
}

- (instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)message andMessageAlignment:(NSTextAlignment)textAlignment andItem:(NSArray<NSString *> *)itemArr andSelectBlock:(void(^)(NSInteger index))selectBlock
{
    self = [super init];
    if (self) {
        
        //基本配置调用放最前面
        [self defaultValueMethod];
        
        self.finishBlock = selectBlock;
        
        self.messageAlignment = textAlignment;
        
        self.titleString = title;
        
        self.messageString = message;
        
        self.itemArr = itemArr;
        
        //上面收到数据之后 UI布局放最后面，内容决定布局
        [self addConstraintsAndActions];
        
    }
    return self;
}

/*********基本配置 可根据自身UI风格适当修改**********/
/** 属性赋值配置不可删除 删除之后可能因为取不到值就蹦了 */
- (void)defaultValueMethod
{
    //自身背景色
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 12;
    
    //自身弹出alertView的宽度 屏幕宽*（0.5~0.9之间最佳）
    viewWith = [UIScreen mainScreen].bounds.size.width - 37.5 * 2;
    
    //title距离顶部的距离 可适当修改
    viewTop = 24;
    
    //副标题或描述距离左右的距离 可适当修改
    viewLeftRight = 2130;
    
    //副标题或描述的字体大小
    messageLabelFont = 15;
    
    //副标题或描述多行情况下上下两行间的行距 可适当修改
    messageLineSpace = 4;
    
    //副标题或描述与横线之间的距离 大于0 适当调
    msgAndLineViewSpace = 21;
    
    //titleLabel最顶上大标题占的高度 可适当修改
    titleHeight = 22;
    
    //底部按钮item占的高度 可适当修改
    btnHeight = 48;
    
    //自身背景灰色的alpha 0~1 可适当修改 越大越灰
    bgViewAlpha = 0.8;
    
}


#pragma mark - creatUI lazy

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17.0f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:0.4];
        _messageLabel.font = [UIFont systemFontOfSize:messageLabelFont];
        _messageLabel.textAlignment = self.messageAlignment;
        _messageLabel.numberOfLines = 0;
        [self addSubview:_messageLabel];
    }
    return _messageLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.03];
        [self addSubview:_lineView];
    }
    return _lineView;
}

- (NSMutableArray *)buttonArr
{
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray array];
    }
    return _buttonArr;
}

- (NSMutableArray *)btnLineArr
{
    if (!_btnLineArr) {
        _btnLineArr = [NSMutableArray array];
    }
    return _btnLineArr;
}

#pragma mark - layout
- (void)addConstraintsAndActions
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        if (self.titleString.length == 0) {
            make.top.equalTo(@0);
        } else {
            make.top.equalTo(@24);
        }
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.titleString.length == 0) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(24);
        } else {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(13);
        }
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLabel.mas_bottom).offset(21);
        make.left.right.equalTo(self).offset(0);
        make.height.offset(2);
        make.bottom.equalTo(self).offset(-52);
    }];
    
    [self layoutIfNeeded];
    [self creatButtonWithCount:(self.itemArr.count > 3 ? 3 : self.itemArr.count)];

    
}

- (void)creatButtonWithCount:(NSInteger)btncount
{
    CGFloat btnW = viewWith/btncount;
    CGFloat btnH = btnHeight;
//    CGFloat btnY = self.lineView.bottom;
    
    for (int  i = 0; i < btncount; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.itemArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16.0f];
        [self addSubview:button];
        [button addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArr addObject:button];
        button.tag = 10+i;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineView.mas_bottom).offset(0);
            make.left.equalTo(self).offset(btnW*i);
            make.height.offset(btnH);
            make.width.offset(btnW);
        }];
    }
        
    if (btncount > 1) {
        for (int i = 1; i < btncount; i ++) {
            UIView *btnLineView = [[UIView alloc] init];
            btnLineView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.03];
            [self addSubview:btnLineView];
            [self.btnLineArr addObject:btnLineView];
            [btnLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineView.mas_bottom).offset(0);
                make.left.equalTo(self).offset(btnW*i);
                make.height.offset(btnH);
                make.width.offset(2);
            }];
        }
    }
    
    
    
}

#pragma mark - buttonAction

- (void)cancelButtonAction:(UIButton *)btn
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        
        self.transform = CGAffineTransformMakeScale(0.0001,0.0001);
        weakSelf.maskView.backgroundColor = [UIColor clearColor];
        
    } completion:^(BOOL finished) {
        [weakSelf.maskView removeFromSuperview];
        weakSelf.maskView = nil;
        
        if (weakSelf.finishBlock) {
            weakSelf.finishBlock(btn.tag-10);
        }
        
    }];
    
}

- (void)showWithView:(UIView *)view
{
    if (view == nil) return;
    if (_maskView == nil) {
        _maskView = [[UIView alloc] initWithFrame:view.bounds];
    }
    
    self.maskView.backgroundColor = [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:(bgViewAlpha < 0 && bgViewAlpha > 1) ? 0.5 : bgViewAlpha];

    [_maskView addSubview:self];
    [view addSubview:_maskView];
    self.center = view.center;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_maskView).offset(37.5);
        make.right.equalTo(_maskView).offset(-37.5);
        make.centerX.equalTo(_maskView.mas_centerX).offset(0);
        make.centerY.equalTo(_maskView.mas_centerY).offset(0);
    }];
    
    self.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - data

- (void)setTitleString:(NSString *)titleString
{
    if (_titleString != titleString) {
        _titleString = titleString;
    }
    
    if (!_titleString.length) return;
    
    self.titleLabel.text = titleString;
    
}

- (void)setMessageString:(NSString *)messageString
{
    if (_messageString != messageString) {
        _messageString = messageString;
    }
    
    if (!_messageString.length) return;
    
    self.messageLabel.text = messageString;
    self.messageLabel.attributedText = [messageString stringWithParagraphlineSpeace:messageLineSpace andAlignment:self.messageAlignment andLabel:self.messageLabel];
    
}

- (void)setLineViewColor:(UIColor *)lineViewColor
{
    if (_lineViewColor != lineViewColor) {
        _lineViewColor = lineViewColor;
    }
    
    _lineView.backgroundColor = lineViewColor;
    
    for (int i = 0; i < self.btnLineArr.count; i ++) {
        
        UIView *btnLineView = self.btnLineArr[i];
        btnLineView.backgroundColor = lineViewColor;
    }
    
}

- (void)setItemTitleColorArr:(NSArray<UIColor *> *)itemTitleColorArr
{
    if (_itemTitleColorArr != itemTitleColorArr) {
        _itemTitleColorArr = itemTitleColorArr;
    }
    
    if (self.buttonArr.count < 1) {
        
        NSLog(@"没有item");
        return;
    }
    if (itemTitleColorArr.count < 1) {
        
        NSLog(@"没有颜色");
        return;
    }
    
    if (self.buttonArr.count > self.itemTitleColorArr.count) {
        
        for (int i = 0; i < itemTitleColorArr.count; i ++) {
            
            UIButton *button = self.buttonArr[i];
            [button setTitleColor:self.itemTitleColorArr[i] forState:UIControlStateNormal];
        }
    }else{
        
        for (int i = 0; i < self.buttonArr.count; i ++) {
            
            UIButton *button = self.buttonArr[i];
            [button setTitleColor:self.itemTitleColorArr[i] forState:UIControlStateNormal];
        }
    }
}

- (void)setTransverseLineHidden:(BOOL)transverseLineHidden
{
    if (_transverseLineHidden != transverseLineHidden) {
        _transverseLineHidden = transverseLineHidden;
    }
    
    self.lineView.hidden = transverseLineHidden;
    
    if (transverseLineHidden) {
        
        for (int i = 0; i < self.btnLineArr.count; i ++) {
            
            UIView *btnLineView = self.btnLineArr[i];
            btnLineView.height = btnHeight*0.4;
            btnLineView.top += btnHeight*0.3;
            //btnLineView.hidden = YES;//设置隐藏竖线
        }
        
    }else{
        
        for (int i = 0; i < self.btnLineArr.count; i ++) {
            
            UIView *btnLineView = self.btnLineArr[i];
            btnLineView.height = btnHeight;
            btnLineView.top = self.lineView.bottom;
            //btnLineView.hidden = NO;
        }
    }
    
}

- (void)setButtonFont:(UIFont *)buttonFont
{
    if (_buttonFont != buttonFont) {
        _buttonFont = buttonFont;
    }
    
    for (int i = 0; i < self.buttonArr.count; i ++) {
        
        UIButton *button = self.buttonArr[i];
        button.titleLabel.font = buttonFont;
    }
}

- (void)setTitleLabelFont:(UIFont *)titleLabelFont
{
    if (_titleLabelFont != titleLabelFont) {
        _titleLabelFont = titleLabelFont;
    }
    
    if (!_titleLabel) return;
    
    _titleLabel.font = titleLabelFont;
    
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor
{
    if (_titleLabelColor != titleLabelColor) {
        _titleLabelColor = titleLabelColor;
    }
    
    if (!_titleLabel) return;
    
    _titleLabel.textColor = titleLabelColor;
    
}

- (void)setMessageLabelColor:(UIColor *)messageLabelColor
{
    if (_messageLabelColor != messageLabelColor) {
        _messageLabelColor = messageLabelColor;
    }
    
    if (!_messageLabel) return;
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithAttributedString:_messageLabel.attributedText];
    // 创建文字属性
    NSDictionary * attriBute = @{NSForegroundColorAttributeName:messageLabelColor, NSFontAttributeName:self.messageLabel.font };
    [attri addAttributes:attriBute range:NSMakeRange(0, self.messageString.length)];
    _messageLabel.attributedText = attri;
    
}

- (void)messageLabelTextColorWith:(NSRange)range andColor:(UIColor *)color
{
    if (!_messageLabel) return;
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithAttributedString:_messageLabel.attributedText];
    [attri addAttribute:NSForegroundColorAttributeName value:color range:range];
    _messageLabel.attributedText = attri;
}


//临时处理
- (void)messageLabelTextColorWith:(NSRange)range andColor:(UIColor *)color addFont:(UIFont *)font {
    if (!_messageLabel) return;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithAttributedString:_messageLabel.attributedText];
    [attri addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attri addAttribute:NSFontAttributeName value:font range:range];
    _messageLabel.attributedText = attri;
}


- (void)dealloc
{
    NSLog(@"-----dealloc----");
}

@end
