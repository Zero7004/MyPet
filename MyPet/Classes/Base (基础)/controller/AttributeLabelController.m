//
//  AttributeLabelController.m
//  MyPet
//
//  Created by 王健龙 on 2020/12/29.
//  Copyright © 2020 王健龙. All rights reserved.
//

#import "AttributeLabelController.h"
#import "HCAttributeLabel.h"
#import "UIColor+hexColor.h"

@interface AttributeLabelController ()
/// 富文本
@property (strong ,nonatomic) HCAttributeLabel *attributedTextLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@end

@implementation AttributeLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self setupViews];
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            make.left.right.equalTo(@0);
            make.width.offset(Screen_Width);
            make.bottom.equalTo(self.view).offset(-Bottom_SafeHeight);
        }];
        
        scrollView;
    });

    self.contentView = ({
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(@0);
            make.width.offset(Screen_Width);
        }];
        
        contentView;
    });
    
    [self.contentView addSubview:self.attributedTextLabel];
    [self.attributedTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

- (void)loadData {
    NSArray *typeArray = @[@{@"path":@"/msg/recommendable",@"title":@"推荐项目"},
                           @{@"path":@"/assess/content",@"title":@"评估规则"},
                           @{@"path":@"/invite/code",@"title":@"邀请规则"},
                           @{@"path":@"/setting/queryQbtAboutUs",@"title":@"关于我们"},
                           @{@"path":@"privacyPolicy",@"title":@"用户协议与隐私条款"},
                           @{@"path":@"/moneyRechargeRule/content",@"title":@"充值规则"},
    ];
    NSString *path = typeArray[self.type][@"path"];
    self.title = typeArray[self.type][@"title"];
    
    if (self.type == AttributeLabelTypePrivacyPolicy) {
        NSError *error=nil;
        NSString *attributedString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
        self.attributedTextLabel.attributedText = [self setAttributedString:attributedString];
        [self setupViews];

    } else {
        [SVProgressHUD show];
        [[KLNetworking shareManager] sendRequestMethod:HTTPMethodGET path:path parameters:@{} success:^(BOOL isSuccess, id  _Nullable responseObject) {
            if ([responseObject[@"code"] integerValue] == RequestSuccess ||
                [responseObject[@"code"] integerValue] == NewRequestSuccess) {
                // 富文本内容
                NSString *attributedString;
                switch (self.type) {
                    case AttributeLabelTypeRecommendable:
                        attributedString = responseObject[@"data"][@"conent"];
                        break;
                    case AttributeLabelTypeAssessmentRule:
                        attributedString = responseObject[@"data"][@"content"];
                        break;
                    case AttributeLabelTypeInvitationRule:
                        attributedString = responseObject[@"data"][@"invitationRule"];
                        break;
                    case AttributeLabelTypeAboutUs:
                        attributedString = responseObject[@"data"][@"content"];
                        break;
                    case AttributeLabelTypePrivacyPolicy:
                        attributedString = responseObject[@"data"][@"privacyPolicy"][@"content"];
                        break;
                    case AttributeLabelTypRechargeRule:
                        attributedString = responseObject[@"data"][@"content"];
                        break;
                    default:
                        break;
                }
                
                self.attributedTextLabel.attributedText = [self setAttributedString:attributedString];
        
                [self setupViews];
            } else {
                [Tools handleServerStatusCodeDictionary:responseObject];
            }
        } failure:^(id  _Nonnull error) {
            
        }];
    }
}

- (void)setType:(AttributeLabelType)type {
    _type = type;
    [self loadData];
}


-(NSMutableAttributedString *)setAttributedString:(NSString *)str {
    //如果有换行，把\n替换成<br/>
    //如果有需要把换行加上
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    //设置HTML图片的宽度
    str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",[UIScreen mainScreen].bounds.size.width,str];
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    //设置富文本字的大小
    [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0, htmlString.length)];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [htmlString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [htmlString length])];
    
    return htmlString;
}

-(CGFloat)getHTMLHeightByStr:(NSString *)str {
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",[UIScreen mainScreen].bounds.size.width,str];
    
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0, htmlString.length)];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:5];
    [htmlString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [htmlString length])];
    
    CGSize contextSize = [htmlString boundingRectWithSize:(CGSize){SCREEN_WIDTH - 34, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return contextSize.height + 10;
    
}

- (HCAttributeLabel *)attributedTextLabel {
    if (!_attributedTextLabel) {
        _attributedTextLabel = [[HCAttributeLabel alloc] init];
        _attributedTextLabel.lineSpacing = 0;
    }
    return _attributedTextLabel;
}

@end

