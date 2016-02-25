//
//  HeadCell.m
//  BaiduAPIRequest
//
//  Created by Macx on 16/2/13.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "HeadCell.h"
#import "UIImageView+WebCache.h"

@implementation HeadCell
{
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet UILabel *_saleNum;
    __weak IBOutlet UILabel *_longTitleLabel;
}

- (void)setImgUrl:(NSString *)imgUrl {
    if (![_imgUrl isEqualToString:imgUrl]) {
        _imgUrl = imgUrl;
        [_image sd_setImageWithURL:[NSURL URLWithString:_imgUrl]];
    }
}

- (void)setTitle:(NSString *)title {
    if (![_title isEqualToString:title]) {
        _title = title;
        _titleLabel.text = _title;
    }
}

- (void)setSale_num:(NSNumber *)sale_num {
    if (_sale_num != sale_num) {
        _sale_num = sale_num;
        _saleNum.text = [NSString stringWithFormat:@"售出%@份", _sale_num];
    }
}

- (void)setLongTitle:(NSString *)longTitle {
    if (![_longTitle isEqualToString:longTitle]) {
        _longTitle = longTitle;
        _longTitleLabel.text = _longTitle;
    }
}

- (void)awakeFromNib {
    // Initialization code
    self.clipsToBounds = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
