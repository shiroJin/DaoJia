//
//  GoodsDetailModel.h
//  DaoJia
//
//  Created by Macx on 16/2/15.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "BaseModel.h"

@interface GoodsDetailModel : BaseModel

@property (nonatomic, copy)NSArray *ImgInfo;
@property (nonatomic, copy)NSString *Title;
@property (nonatomic, copy)NSString *CoverUrl;
@property (nonatomic, copy)NSString *ShareUrl;
@property (nonatomic, copy)NSString *SubTitle;
@property (nonatomic, copy)NSString *DealPrice;
@property (nonatomic, copy)NSString *ShippingInfo;
@property (nonatomic, copy)NSString *ContentParam;
@property (nonatomic, copy)NSArray *Content;
@property (nonatomic, strong)NSNumber *CartNum;
@property (nonatomic, strong)NSNumber *Stock;
@property (nonatomic, copy)NSString *MadeIn;
@property (nonatomic, copy)NSString *GoodsTaste;
@property (nonatomic, copy)NSString *ForecastShippingFee;
@property (nonatomic, copy)NSString *PriceLables;
@property (nonatomic, copy)NSString *Labels;
@property (nonatomic, copy)NSString *Weight;
@property (nonatomic, strong)NSNumber *PricePerKilogram;
@property (nonatomic, copy)NSArray *PromotionActivityList;
@property (nonatomic, copy)NSDictionary *RelationShopList;
@property (nonatomic, copy)NSString *Price;
@property (nonatomic, strong)NSNumber *LikeCount;
@property (nonatomic, copy)NSString *TasteCount;
@property (nonatomic, strong)NSNumber *BuyCount;

@end
