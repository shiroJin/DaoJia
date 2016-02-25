//
//  GuangguangStoreModel.h
//  DaoJia
//
//  Created by Macx on 16/2/10.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "BaseModel.h"

@interface GuangguangStoreModel : BaseModel

@property (nonatomic, strong) NSNumber *StoreId;
@property (nonatomic, copy) NSString *StoreTitle;
@property (nonatomic, copy) NSString *StoreLogoUrl;
@property (nonatomic, strong) NSNumber *UserId;
@property (nonatomic, copy)NSString *UserName;
@property (nonatomic, strong) NSNumber *GoodsId;
@property (nonatomic, copy)NSString *Title;
@property (nonatomic, copy)NSString *SubTitle;
@property (nonatomic, copy)NSString *DealPrice;
@property (nonatomic, copy)NSString *ShippingInfo;
@property (nonatomic, copy)NSString *CoverUrl;
@property (nonatomic, copy)NSString *OpenUrl;
@property (nonatomic, strong) NSNumber *LikeCount;
@property (nonatomic, copy) NSString *Stock;
@property (nonatomic, strong) NSNumber *IsShippingFree;
@property (nonatomic, strong) NSNumber *IsLike;
@property (nonatomic, strong) NSNumber *CartNum;
@property (nonatomic, copy)NSArray *Labels;
@property (nonatomic, copy)NSString *Price;
@property (nonatomic, copy)NSString *Weight;


@end
