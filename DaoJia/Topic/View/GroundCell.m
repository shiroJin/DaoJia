//
//  GroundCell.m
//  好豆菜谱ZN
//
//  Created by Macx on 16/2/21.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "GroundCell.h"

@implementation GroundCell

- (void)awakeFromNib {
//    // Initialization code
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, 1)];
//    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
//    
//    [self addSubview:view];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
//@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *TodayLabel;
//@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

//@property (nonatomic, assign) NSInteger cateId ;
//@property (nonatomic, copy) NSString *imgUrl;
//@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *num;
//@property (nonatomic, copy) NSString *desc;


-(void)setGroundModel:(GroundModel *)groundModel {
    
    if (_groundModel != groundModel) {
        
        _groundModel = groundModel;
        [_mainImageView sd_setImageWithURL:[NSURL URLWithString:_groundModel.imgUrl]];
        _TitleLabel.text = _groundModel.name;
        _TodayLabel.text = [NSString stringWithFormat:@"%@",_groundModel.num];
        _contentLabel.text = _groundModel.desc;
        
        
    }
}

@end
