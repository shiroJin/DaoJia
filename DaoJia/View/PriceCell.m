//
//  PriceCell.m
//  BaiduAPIRequest
//
//  Created by Macx on 16/2/13.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "PriceCell.h"
#import "discountPrice.h"

@implementation PriceCell
{
    __weak IBOutlet UILabel *_currentPriceLabel;
    __weak IBOutlet discountPrice *_priceLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCurrentPrice:(NSNumber *)currentPrice {
    if (_currentPrice != currentPrice) {
        _currentPrice = currentPrice;
        _currentPriceLabel.text = [NSString stringWithFormat:@"￥%.2f", [_currentPrice floatValue] / 100];
    }
}

- (void)setMarketPrice:(NSNumber *)marketPrice {
    if (_marketPrice != marketPrice) {
        _marketPrice = marketPrice;
        _priceLabel.price = _marketPrice;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
