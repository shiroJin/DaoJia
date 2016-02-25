//
//  KitchenTableViewCell.m
//  项目三首页
//
//  Created by mac on 16/2/15.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "KitchenTableViewCell.h"

@implementation KitchenTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ListModel *)model {

    if (_model != model) {
        _model = model;
        
        if (_model.image) {
            [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.image]];
        }else if (_model.cover){
            [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.cover]];
        }
        _titleLabel.text = _model.title;
        _authorLabel.text = _model.collection;
        if (_model.content) {
            _introLabel.text = _model.content;
        }else if (_model.stuff) {
            _introLabel.text = _model.stuff;
        }
        
        if (_model.hasVideo) {
            _videoImage.hidden = NO;
        }else {
            _videoImage.hidden = YES;
        }
        
    }
}

@end
