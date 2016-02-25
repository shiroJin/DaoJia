//
//  ContentCell.m
//  DaoJia
//
//  Created by Macx on 16/2/15.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "ContentCell.h"

@implementation ContentCell
{
    __weak IBOutlet UIImageView *_imageView;
}


- (void)setImgUrl:(NSString *)imgUrl {
    if (![_imgUrl isEqualToString:imgUrl]) {
        _imgUrl = imgUrl;
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_imgUrl]];
    }
}

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
