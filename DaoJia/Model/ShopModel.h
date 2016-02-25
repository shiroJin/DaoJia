//
//  ShopModel.h
//  BaiduAPIRequest
//
//  Created by Macx on 16/2/13.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//


#import "BaseModel.h"
@interface ShopModel : BaseModel

@property (nonatomic, strong)NSNumber *shop_id;
@property (nonatomic, strong)NSNumber *longitude;
@property (nonatomic, strong)NSNumber *latitude;
@property (nonatomic, strong)NSNumber *distance;
@property (nonatomic, copy)NSString *shop_url;
@property (nonatomic, copy)NSString *shop_murl;

@end
