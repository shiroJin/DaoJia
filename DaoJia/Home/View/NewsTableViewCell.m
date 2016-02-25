//
//  NewsTableViewCell.m
//  项目三首页
//
//  Created by mac on 16/2/13.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

- (void)awakeFromNib {

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ListModel *)model {
    
    if (_model != model) {
        _model = model;
        
        [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.img]];
        _titleLabel.text = _model.title;
        _introLabel.text = _model.intro;
    }
    
}


@end
