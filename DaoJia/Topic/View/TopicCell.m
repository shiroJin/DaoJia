//
//  TopicCell.m
//  好豆菜谱ZN
//
//  Created by Macx on 16/2/21.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "TopicCell.h"

@implementation TopicCell

- (void)awakeFromNib {


}

-(void)setTopModel:(TopModel *)topModel {
    
    if (_topModel != topModel) {
        _topModel = topModel;
        
        [_mainImageVIew sd_setImageWithURL:[NSURL URLWithString:_topModel.imaUrl]];
        _titleLable.text = _topModel.title;
        [_userImageView sd_setImageWithURL:[NSURL URLWithString:_topModel.avatar]];
        _userImageView.layer.masksToBounds = YES;
        _userImageView.layer.cornerRadius = _userImageView.width /2;
        _UseNameLabel.text = _topModel.userName;
        _ContentLable.text = _topModel.previewContent;

        
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
