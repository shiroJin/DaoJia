//
//  GuangguangCell.m
//  DaoJia
//
//  Created by Macx on 16/2/10.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "GuangguangCell.h"
#import "GuangguangStoreModel.h"
#import "UIImageView+WebCache.h"

#define kSeparatorSize 5

@implementation GuangguangCell
{
    __weak IBOutlet UIImageView *_storeIcon;
    __weak IBOutlet UILabel *_storeTitle;
    __weak IBOutlet UILabel *_userName;
    __weak IBOutlet UILabel *_stock;
    __weak IBOutlet UIImageView *_coverImg;
    __weak IBOutlet UILabel *_dealPrice;
    __weak IBOutlet UIButton *_purchaseBtn;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _storeIcon.layer.cornerRadius = _storeIcon.bounds.size.width / 2;
        _storeIcon.layer.masksToBounds = YES;
        
        _purchaseBtn.layer.cornerRadius = 8;
        _purchaseBtn.layer.masksToBounds = YES;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _storeIcon.layer.cornerRadius = _storeIcon.bounds.size.width / 2;
    _storeIcon.layer.masksToBounds = YES;

    _purchaseBtn.layer.cornerRadius = 8;
    _purchaseBtn.layer.masksToBounds = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setModel:(GuangguangStoreModel *)model {
    if (_model != model) {
        _model = model;
        
        [_storeIcon sd_setImageWithURL:[NSURL URLWithString:_model.StoreLogoUrl]];
        _storeTitle.text = _model.StoreTitle;
        _userName.text = _model.UserName;
        _stock.text = [NSString stringWithFormat:@"剩余%@份", _model.Stock];
        [_coverImg sd_setImageWithURL:[NSURL URLWithString:_model.CoverUrl]];
        _dealPrice.text = _model.DealPrice;
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0.8, 0.8, 0.8, 1);
    CGContextFillRect(context, CGRectMake(0, rect.size.height - kSeparatorSize, rect.size.width, kSeparatorSize));
}

@end
