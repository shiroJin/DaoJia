//
//  GoodsInfoCell.m
//  DaoJia
//
//  Created by Macx on 16/2/15.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "GoodsInfoCell.h"
#import "discountPrice.h"
#import "GoodsDetailModel.h"

@implementation GoodsInfoCell
{
    __weak IBOutlet UILabel *_title;
    __weak IBOutlet UILabel *_subTitle;
    __weak IBOutlet UILabel *_dealPrice;
    __weak IBOutlet discountPrice *_price;
    __weak IBOutlet UILabel *_priceKilogram;
    __weak IBOutlet UILabel *_stock;
    
}

- (void)setGoods:(GoodsDetailModel *)goods {
    if (_goods != goods) {
        _goods = goods;
        
        _title.text = goods.Title;
        _subTitle.text = goods.SubTitle;
        _dealPrice.text = goods.DealPrice;
        _price.strPrice = goods.Price;
        _priceKilogram.text = [NSString stringWithFormat:@"￥%@/500g", goods.PricePerKilogram];
        _stock.text = [NSString stringWithFormat:@"库存：%@件", goods.Stock];
    }
}


- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
