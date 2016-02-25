//
//  ADGoodsModel.h
//  DaoJia
//
//  Created by Macx on 16/2/11.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "BaseModel.h"

@interface ADGoodsModel : BaseModel

@property (nonatomic, strong) NSNumber *GoodsId;
@property (nonatomic, copy)NSString *Title;
@property (nonatomic, copy)NSString *CoverUrl;
@property (nonatomic, copy)NSString *DealPrice;
@property (nonatomic, copy) NSString *Stock;
@property (nonatomic, copy)NSString *ShippingInfo;
@property (nonatomic, copy)NSString *Weight;
@property (nonatomic, copy)NSArray *Labels;
@property (nonatomic, copy)NSString *Price;

@end
