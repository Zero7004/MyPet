//
//  ShareView.m
//  MyPet
//
//  Created by 王健龙 on 2019/6/14.
//  Copyright © 2019 王健龙. All rights reserved.
//

#import "ShareView.h"
#import "ShareCollectionViewCell.h"

#import "OpenShareHeader.h"
#import <UMShare/UMShare.h>

#define shareHeight 162.0
@interface ShareView () <UICollectionViewDelegate,UICollectionViewDataSource>
/// 分享背景视图
@property (strong ,nonatomic) UIView *shareBackGroundView;
/// 分享菜单
@property (strong ,nonatomic) NSMutableArray *menuArray;
/// 分享collection
@property (strong ,nonatomic) UICollectionView *shareCollectionView;
@end

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        //设置蒙版
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        [self initData];
        [self initUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.shareBackGroundView.top = self.shareBackGroundView.top - shareHeight;
    }];
    
}

- (void)setShareLink:(NSString *)shareLink {
    _shareLink = shareLink;
}

- (void)setImage:(UIImage *)image {
    _image = image;
}

- (void)setTitle:(NSString *)title {
    _title = title;
}

#pragma mark - 初始化数据
- (void)initData {
    self.menuArray = [@[
  @{@"name":@"微博",@"icon":@"share_weibo"},
//  @{@"name":@"QQ好友",@"icon":@"share_qq"},
//  @{@"name":@"QQ空间",@"icon":@"share_qqzone"},
  @{@"name":@"微信好友",@"icon":@"share_weixin"},
  @{@"name":@"朋友圈",@"icon":@"share_friends"}] mutableCopy];
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
    
    [self addSubview:self.shareBackGroundView];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 24, SCREEN_WIDTH, 25);
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18.0];
    titleLabel.text = @"分享至";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = RGB(26, 26, 26);
    [self.shareBackGroundView addSubview:titleLabel];
    
    [self.shareBackGroundView addSubview:self.shareCollectionView];
}


#pragma mark - UICollectionView代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.menuArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShareCollectionViewCell" forIndexPath:indexPath];
    cell.iconImageView.image = [UIImage imageNamed:self.menuArray[indexPath.row][@"icon"]];
    cell.nameLabel.text = self.menuArray[indexPath.row][@"name"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    OSMessage *msg=[[OSMessage alloc] init];
    msg.title = self.title;
    msg.link  = self.shareLink;
    msg.image = UIImagePNGRepresentation([UIImage imageNamed:@"AppIcon"]);
    msg.desc = self.desc ?: self.shareLink;
    switch (indexPath.row) {
        case 0:
            // 微博
            if ([OpenShare isWeiboInstalled]) {
                [OpenShare shareToWeibo:msg Success:^(OSMessage *message) {
                    [SVProgressHUD showWithStatus:@"分享成功"];
                    [self removeFromSuperview];
                } Fail:^(OSMessage *message, NSError *error) {
                    NSLog(@">>>>%@,--->%@",message,error);
                }];
            }
            break;
//        case 1:
//            // QQ好友
//            if ([OpenShare isQQInstalled]) {
//                [self shareWebPageToPlatformType:UMSocialPlatformType_QQ];
//            }
//            break;
//        case 2:
//            // QQ空间
//            if ([OpenShare isQQInstalled]) {
//                [self shareWebPageToPlatformType:UMSocialPlatformType_Sina];
//            }
//            break;
        case 1:
            // 微信好友
            if ([OpenShare isWeixinInstalled]) {
                [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
                    [SVProgressHUD showWithStatus:@"分享成功"];
                    [self removeFromSuperview];
                } Fail:^(OSMessage *message, NSError *error) {
                    NSLog(@">>>>%@,--->%@",message,error);
                }];
            }
            break;
        case 2:
            // 微信朋友圈
            if ([OpenShare isWeixinInstalled]) {
                [OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
                    [SVProgressHUD showWithStatus:@"分享成功"];
                    [self removeFromSuperview];
                } Fail:^(OSMessage *message, NSError *error) {
                    NSLog(@">>>>%@,--->%@",message,error);
                }];
            }
            break;
        default:
            break;
    }
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://mobile.umeng.com/social";

    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[Tools getCurrentVC] completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

#pragma mark - 移除
- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.shareBackGroundView.bottom = self.shareBackGroundView.bottom + shareHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 懒加载
- (UIView *)shareBackGroundView {
    if (!_shareBackGroundView) {
        _shareBackGroundView = [[UIView alloc] init];
        _shareBackGroundView.backgroundColor = [UIColor whiteColor];
        _shareBackGroundView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, shareHeight + 10);
        _shareBackGroundView.layer.cornerRadius = 10;
    }
    return _shareBackGroundView;
}

- (UICollectionView *)shareCollectionView {
    if (!_shareCollectionView) {
        CGFloat cellWidth  = SCREEN_WIDTH / self.menuArray.count - 1;
        CGFloat cellHeight = 90;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(cellWidth, cellHeight);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _shareCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 73, SCREEN_WIDTH, cellHeight + BottomSafeAreaHeight) collectionViewLayout:layout];
        _shareCollectionView.backgroundColor = color_white;
        _shareCollectionView.delegate = self;
        _shareCollectionView.dataSource = self;
        [_shareCollectionView registerNib:[UINib nibWithNibName:@"ShareCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShareCollectionViewCell"];
    }
    return _shareCollectionView;
}

- (NSMutableArray *)menuArray {
    if (!_menuArray) {
        _menuArray = [NSMutableArray array];
    }
    return _menuArray;
}
@end
