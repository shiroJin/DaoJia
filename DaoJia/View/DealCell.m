//
//  DealCell.m
//  DaoJia
//
//  Created by Macx on 16/2/14.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "DealCell.h"
#define kSeparatorSize 5

@implementation DealCell
{
    __weak IBOutlet UILabel *_storeTitle;
    __weak IBOutlet UILabel *_userName;
    __weak IBOutlet UILabel *_stock;
    __weak IBOutlet UIImageView *_coverImg;
    __weak IBOutlet UILabel *_dealPrice;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setModel:(DealModel *)model {
    if (_model != model) {
        _model = model;
        
        _storeTitle.text = _model.title;
        _userName.text = _model.min_title;
        _stock.text = [NSString stringWithFormat:@"售出%@份", _model.sale_num];
        [_coverImg sd_setImageWithURL:[NSURL URLWithString:_model.image]];
        _dealPrice.text = [NSString stringWithFormat:@"￥%.2f", [_model.current_price floatValue]/100];
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0.8, 0.8, 0.8, 1);
    CGContextFillRect(context, CGRectMake(0, rect.size.height - kSeparatorSize, rect.size.width, kSeparatorSize));
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
