//
//  AlbumTableViewCell.m
//  项目三首页
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "AlbumTableViewCell.h"

@implementation AlbumTableViewCell

- (void)awakeFromNib {

    self.introLabel.linespace = kLineSpace;
    self.introLabel.font = [UIFont systemFontOfSize:kTextHeight];
    self.introLabel.numberOfLines = 0;
    
    self.imageUiView.clipsToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ListModel *)model {
    
    if (_model != model) {
        _model = model;
        
        [_recipeImageView sd_setImageWithURL:[NSURL URLWithString:_model.cover]];
        _titleLabel.text = _model.title;
        _userNameLabel.text = [NSString stringWithFormat:@"by %@", _model.userName];
        
        if (_model.intro) {
            _introLabel.text = _model.intro;
            
            CGFloat height = [WXLabel getTextHeight:kTextHeight width:kScreenWidth - 20 text:_model.intro linespace:kLineSpace];
            
            _introLabel.height = height;
        } else if (_model.tags.count > 0) {
            for (TagModel *model in _model.tags) {
                
                _introLabel.text = [_introLabel.text stringByAppendingFormat:@"%@  ", model.name];
                
            }
            
            _introLabel.size = CGSizeMake(kScreenWidth, 20);
        }
        
        if (_model.likeCount > 1000) {
            _likeCount.text = @"999+";
        } else {
            _likeCount.text = [NSString stringWithFormat:@"%ld", _model.likeCount];
        }
        
        if (_model.hasVideo) {
            _videoImage.hidden = NO;
        }else {
            _videoImage.hidden = YES;
        }
    }

}

@end
