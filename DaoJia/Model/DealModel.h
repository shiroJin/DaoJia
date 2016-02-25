//
//  DealModel.h
//  BaiduAPIRequest
//
//  Created by Macx on 16/2/13.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "BaseModel.h"
#import "ShopModel.h"
@interface DealModel : BaseModel

@property (nonatomic, strong)NSNumber *deal_id;
@property (nonatomic, copy)NSString *image;
@property (nonatomic, copy)NSString *tiny_image;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *min_title;
@property (nonatomic, copy)NSString *description;
@property (nonatomic, strong)NSNumber *market_price;
@property (nonatomic, strong)NSNumber *current_price;
@property (nonatomic, strong)NSNumber *promotion_price;
@property (nonatomic, strong)NSNumber *sale_num;
@property (nonatomic, strong)NSNumber *score;
@property (nonatomic, strong)NSNumber *comment_num;
@property (nonatomic, strong)NSNumber *publish_time;
@property (nonatomic, strong)NSNumber *purchase_deadline;
@property (nonatomic, assign)BOOL is_reservation_required;
@property (nonatomic, strong)NSNumber *distance;
@property (nonatomic, strong)NSNumber *shop_num;
@property (nonatomic, copy)NSString *deal_url;
@property (nonatomic, copy)NSString *deal_murl;
//@property (nonatomic, copy)NSArray *shops;
@property (nonatomic, strong)ShopModel *shop;

@end
