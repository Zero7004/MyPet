//
//  EarningsViewController.m
//  MyPet
//
//  Created by long on 2022/7/19.
//  Copyright © 2022 王健龙. All rights reserved.
//

#import "EarningsViewController.h"
#import <SVGAPlayer/SVGA.h>

@interface EarningsViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIView *myView;
@property (nonatomic, assign) BOOL beginAni;
@property (nonatomic, strong) SVGAPlayer *svga;

@property (nonatomic, strong) NSMutableArray *petArray;
@property (nonatomic, strong) NSMutableArray *petItemArray;

@end

@implementation EarningsViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    NSLog(@"viewWillDisappear");
    self.beginAni = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSLog(@"viewWillAppear");
    self.beginAni = YES;
//    [self beginAnimation];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.beginAni = YES;
    
    UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgWord"]];
    [self.view addSubview:bgImg];
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view).offset(0);
    }];
    
//    [self.view addSubview:self.myView];
//    [self.view addSubview:self.svga];
    
    for (int i = 0; i < 20; i++) {
        [self.petArray addObject:@"cat"];
    }
    
    __weak typeof(self) weakSelf = self;
    [self.petArray enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL * _Nonnull stop) {
        SVGAPlayer *svga = [weakSelf getSVGAPlayerWithIndex:idx];
        [self.view addSubview:svga];
        [weakSelf.petItemArray addObject:svga];
        [weakSelf setAnimationWith:idx];
    }];
    
    [self.petItemArray enumerateObjectsUsingBlock:^(SVGAPlayer *svga, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf beginAnimationWith:svga];
    }];


//    [self.myView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(self.view).offset(100);
//        make.width.equalTo(@200);
//        make.height.equalTo(@100);
//    }];
    
    
//    [self beginTranslationAnimation];
    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, 400)]; // 起点
//    // 设置终点 和两个控制点（拐点）
//    [path addCurveToPoint:CGPointMake(100, 200) controlPoint1:(CGPointMake(120, 10)) controlPoint2:(CGPointMake(300, 20))];
//
////     第二步：绘制运动路径轨迹
//    CAShapeLayer *pathLayer = [CAShapeLayer layer];
//    pathLayer.path = path.CGPath;// 绘制路径
//    pathLayer.strokeColor = [UIColor redColor].CGColor;// 轨迹颜色
//    pathLayer.fillColor = [UIColor clearColor].CGColor;// 填充颜色
//    pathLayer.lineWidth = 5.0f; // 线宽
//
//    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    //pathAnimation.calculationMode = kCAAnimationPaced;// 我理解为节奏
//     pathAnimation.fillMode = kCAFillModeForwards;
//      pathAnimation.removedOnCompletion = NO;// 是否在动画完成后从 Layer 层上移除  回到最开始状态
//      pathAnimation.duration = 3.0f;// 动画时间
//      pathAnimation.repeatCount = 1;// 动画重复次数```
//
//    [self.myView.layer addAnimation:pathAnimation forKey:nil ];// 添加动画
//    [self.view.layer addSublayer:pathLayer];// 绘制的轨迹
}

- (UIView *)myView {
    if (_myView) {
        return _myView;
    }
    _myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _myView.backgroundColor = [UIColor clearColor];
    
    return _myView;
}

- (SVGAPlayer *)svga {
    if (_svga) {
        return _svga;
    }
    _svga = [[SVGAPlayer alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _svga.contentMode = UIViewContentModeScaleAspectFill;
    SVGAParser *parser = [[SVGAParser alloc] init];
    __weak typeof(self) weakSelf = self;
    [parser parseWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cat" ofType:@"svga"]] completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
        
        if (videoItem) {
            weakSelf.svga.videoItem = videoItem;
            [weakSelf.svga startAnimation];
        }
        
    } failureBlock:^(NSError * _Nullable error) {
        NSLog(@"加载失败 %@", error);
    }];
    _svga.userInteractionEnabled = YES;
    _svga.loops = INT16_MAX;
    _svga.clearsAfterStop = YES;
    
    return _svga;
}

- (SVGAPlayer *)getSVGAPlayerWithIndex:(NSInteger)index {
    CGPoint point = [self getRandomPoint];
    SVGAPlayer *svga = [[SVGAPlayer alloc] initWithFrame:CGRectMake(point.x, point.y, 100, 100)];
    svga.contentMode = UIViewContentModeScaleAspectFill;
    svga.userInteractionEnabled = YES;
    svga.loops = INT16_MAX;
    svga.clearsAfterStop = YES;
    svga.tag = 10000 + index;
    return svga;
}

- (CGPoint)getRandomPoint {
    int x = rand() % lround(SCREEN_WIDTH - 20);
    int y = rand() % lround(SCREEN_HEIGHT - 200);
    return CGPointMake(x, y);
}

- (void)setAnimationWith:(NSInteger)index {
    SVGAParser *parser = [[SVGAParser alloc] init];
    __weak typeof(self) weakSelf = self;
    [parser parseWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.petArray[index] ofType:@"svga"]] completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
        
        if (videoItem) {
            SVGAPlayer *svga = weakSelf.petItemArray[index];
            svga.videoItem = videoItem;
            [svga startAnimation];
        }
        
    } failureBlock:^(NSError * _Nullable error) {
        NSLog(@"加载失败 %@", error);
    }];
}

- (void)beginAnimationWith:(SVGAPlayer *)svga {
    if (!self.beginAni) {
        return;
    }
    int x1 = svga.frame.origin.x;
    int y1 = svga.frame.origin.y;
    NSLog(@"坐标1 %d %d", x1, y1);

    int x2 = rand() % lround(SCREEN_WIDTH - 20);
    int y2 = rand() % lround(SCREEN_HEIGHT - 200);
    NSLog(@"坐标2 %d %d", x2, y2);
    
    //速度暂定为 v = 2
    double v = 80;
    //距离 s
    double s = sqrt(pow((x1 - x2), 2) + pow((y1 - y2), 2));
    //时间 t
    double t = s / v;
    NSLog(@"距离 %f 时间 %f", s, t);

//    [UIView animateWithDuration:t animations:^{
//        self.myView.frame = CGRectMake(x2, y2, 100, 100);
//    } completion:^(BOOL finished) {
//        [self beginAnimation];
//        NSLog(@"开始执行平移动画");
//    }];
    
    
    [UIView animateKeyframesWithDuration:t delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        svga.frame = CGRectMake(x2, y2, 100, 100);
    } completion:^(BOOL finished) {
        [self beginAnimationWith:svga];
        NSLog(@"开始执行平移动画");
    }];
}


- (NSMutableArray *)petArray {
    if (!_petArray) {
        _petArray = [NSMutableArray new];
    }
    return _petArray;
}

- (NSMutableArray *)petItemArray {
    if (!_petItemArray) {
        _petItemArray = [NSMutableArray new];
    }
    return _petItemArray;
}


- (void)beginAnimation {
    if (!self.beginAni) {
        return;
    }
    int x1 = self.svga.frame.origin.x;
    int y1 = self.svga.frame.origin.y;
    NSLog(@"坐标1 %d %d", x1, y1);

    int x2 = rand() % lround(SCREEN_WIDTH);
    int y2 = rand() % lround(SCREEN_HEIGHT - 200);
    NSLog(@"坐标2 %d %d", x2, y2);
    
    //速度暂定为 v = 2
    double v = 80;
    //距离 s
    double s = sqrt(pow((x1 - x2), 2) + pow((y1 - y2), 2));
    //时间 t
    double t = s / v;
    NSLog(@"距离 %f 时间 %f", s, t);

//    [UIView animateWithDuration:t animations:^{
//        self.myView.frame = CGRectMake(x2, y2, 100, 100);
//    } completion:^(BOOL finished) {
//        [self beginAnimation];
//        NSLog(@"开始执行平移动画");
//    }];
    
    
    [UIView animateKeyframesWithDuration:t delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        self.svga.frame = CGRectMake(x2, y2, 100, 100);
    } completion:^(BOOL finished) {
        [self beginAnimation];
        NSLog(@"开始执行平移动画");
    }];
}

//开始平移动画
- (void)beginTranslationAnimation {
    NSLog(@"开始执行平移动画");
    int count = rand() % 100;
    NSLog(@"生成随机数 %d", count);
    CABasicAnimation *animation1 = [CABasicAnimation animation];
    //注意：不能使用transform.position.x,那样的话动画无效
    animation1.keyPath = @"position.y";
    animation1.duration = 1.0f;
    animation1.byValue = @(count);
    animation1.beginTime = 0.f;
    animation1.delegate = self;
    //动画维持结束后的状态
    animation1.removedOnCompletion = NO;
    animation1.fillMode = kCAFillModeForwards;
    [self.myView.layer addAnimation:animation1 forKey:@"animation1"];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"动画开始执行");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        
        NSLog(@"动画正常结束");
        [self beginTranslationAnimation];
    } else {
        NSLog(@"动画被打断，未正常结束");
    }
}



@end
