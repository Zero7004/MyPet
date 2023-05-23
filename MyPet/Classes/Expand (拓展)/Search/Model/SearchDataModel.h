//
//  SearchDataModel.h
//  Loans_Users
//
//  Created by long on 2021/11/27.
//  Copyright © 2021 王健龙. All rights reserved.
//

#import "MCBaseModel.h"
#import "MCSubBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class SearchFinancialBrokersModel,SearchHousingQuestionsModel,SearchInformationsModel,SearchProductsModel, HousingDetailVo;
@protocol FinancialBrokerListModel, HousingQuestionListModel, InformationListModel, ProductListModel;
@interface SearchDataModel : MCBaseModel

@property (nonatomic, strong) SearchFinancialBrokersModel *financialBrokers; //会员学院
@property (nonatomic, strong) SearchHousingQuestionsModel *housingQuestions; //问答社区
@property (nonatomic, strong) SearchInformationsModel *informations;  //快讯
@property (nonatomic, strong) SearchProductsModel *products;   //产品

@end

@interface SearchFinancialBrokersModel : MCSubBaseModel
@property (nonatomic, assign) NSInteger financialBrokerTotal;
@property (nonatomic, strong) NSArray <FinancialBrokerListModel>*financialBrokerList;
@end
@interface FinancialBrokerListModel : MCSubBaseModel
@property (nonatomic, copy)   NSString *typeId;
@property (nonatomic, copy)   NSString *content;
@property (nonatomic, copy)   NSString *publishTime;
@property (nonatomic, copy)   NSString *id;
@property (nonatomic, assign) NSInteger isTop;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, assign) NSInteger clickCount;
@property (nonatomic, copy)   NSString *cover;
@property (nonatomic, copy)   NSString *createTime;
@end



@interface SearchHousingQuestionsModel : MCSubBaseModel
@property (nonatomic, assign) NSInteger housingQuestionTotal;
@property (nonatomic, strong) NSArray <HousingQuestionListModel>*housingQuestionList;
@end
@interface HousingQuestionListModel : MCSubBaseModel
@property (nonatomic, assign) NSInteger isBest;
@property (nonatomic, strong) HousingDetailVo *answerDetailVo;
@property (nonatomic, copy)  NSString *reading;
@property (nonatomic, assign) NSInteger isTop;
@property (nonatomic, assign)  NSString *thumbsUp;
@property (nonatomic, copy)   NSString *questionContent;
@property (nonatomic, copy)   NSString *questionId;
@property (nonatomic, assign)  NSString *comment;
@property (nonatomic, copy)   NSString *createTime;
@property (nonatomic, copy)   NSString *questionType;
@end
@interface HousingDetailVo : MCSubBaseModel

@property (nonatomic, copy)   NSString *questionId;
@property (nonatomic, assign) NSInteger isAdopt;
@property (nonatomic, copy)   NSString *customerName;
@property (nonatomic, copy)   NSString *answerId;
@property (nonatomic, copy)   NSString *headImg;
@property (nonatomic, assign) NSInteger isThumbsUp;
@property (nonatomic, copy)   NSString *answerContent;
@property (nonatomic, copy)   NSString *createTime;

@end




@interface SearchInformationsModel : MCSubBaseModel
@property (nonatomic, assign) NSInteger informationTotal;
@property (nonatomic, strong) NSArray <InformationListModel>*informationList;
@end
@interface InformationListModel : MCSubBaseModel
@property (nonatomic, copy)   NSString *informationContent;
@property (nonatomic, copy)   NSString *releaseTime;
@property (nonatomic, copy)   NSString *informationTitle;
@property (nonatomic, copy)   NSString *informationAuthor;
@property (nonatomic, copy)   NSString *informationId;
@property (nonatomic, assign) NSInteger browseNumber;
@property (nonatomic, copy)   NSString *shareLink;
@property (nonatomic, copy)   NSString *informationIcon;

@end



@interface SearchProductsModel : MCSubBaseModel
@property (nonatomic, assign) NSInteger productTotal;
@property (nonatomic, strong) NSArray <ProductListModel>*productList;
@end
@interface ProductListModel : MCSubBaseModel
@property (nonatomic, copy)   NSString *productId;
@property (nonatomic, copy)   NSString *loanLimitUnit;
@property (nonatomic, copy)   NSString *interestRate;
@property (nonatomic, copy)   NSString *introduction;
@property (nonatomic, copy)   NSString *subtitle;
@property (nonatomic, assign) NSInteger loanLimit;
@property (nonatomic, copy)   NSString *timeLimit;
@property (nonatomic, copy)   NSString *productImg;
@property (nonatomic, copy)   NSString *maxLoanable;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *applyDuration;
@property (nonatomic, copy)   NSString *productLabel;
@property (nonatomic, copy) NSString *borrowingRate;
@property (nonatomic, copy)   NSString *borrowingRateUnit;
@property (nonatomic, copy)   NSString *reimbursementType;
@end



NS_ASSUME_NONNULL_END
