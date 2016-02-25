//
//  PeopleCell.m
//  好豆菜谱ZN
//
//  Created by Macx on 16/2/22.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "PeopleCell.h"

@implementation PeopleCell

- (void)awakeFromNib {

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(TopModel *)model {
    
    
    if (_model != model) {
        
        _model = model;
        [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.avatar]];
        _userNameLabel.text = _model.userName;
        _introLabel.text = _model.intro;
        _titleLabel.text = _model.title;
        _addLabel.text = _model.address;
//        imageView.layer.masksToBounds = YES;
//        imageView.layer.cornerRadius = imageView.width / 2;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = _avatarImageView.width / 2;
        
        
//        _addLabel.font = [UIFont systemFontOfSize:8];
        
    }
}
-(void)setPeopleModel:(PeopleModel *)peopleModel {
    
    if (_peopleModel != peopleModel) {
        
        _peopleModel = peopleModel;
        _descLabel.text = _peopleModel.desc;
        _titleLabel.text = _peopleModel.title;
        [_imgView sd_setImageWithURL:[NSURL URLWithString:_peopleModel.imaUrl]];
//        _descLabel.font = [UIFont systemFontOfSize:5];
//        _descLabel.numberOfLines = 2;
        
        
        
    }
    
    
    
}
@end
