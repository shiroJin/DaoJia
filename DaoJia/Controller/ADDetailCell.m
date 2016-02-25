//
//  ADDetailCell.m
//  DaoJia
//
//  Created by Macx on 16/2/12.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "ADDetailCell.h"
#import "ADGoodsModel.h"

#define kSeparateWidth 8

@implementation ADDetailCell
{
    __weak IBOutlet UIImageView *_img;
    __weak IBOutlet UILabel *_title;
    __weak IBOutlet UILabel *_dealPrice;
    __weak IBOutlet UILabel *_stock;
    
}

- (void)setGoods:(ADGoodsModel *)goods {
    if (_goods != goods) {
        _goods = goods;
        
        [_img sd_setImageWithURL:[NSURL URLWithString:_goods.CoverUrl]];
        _title.text = _goods.Title;
        _dealPrice.text = _goods.DealPrice;
        _stock.text = _goods.Stock;
    }
}

//绘制分隔线
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0.95, 0.95, 0.95, 1);
    CGContextFillRect(context, CGRectMake(0, 0, rect.size.width, kSeparateWidth));
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
