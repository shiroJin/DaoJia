//
//  DailyCell.m
//  DaoJia
//
//  Created by Macx on 16/2/10.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "DailyCell.h"
#import "DailyModel.h"
#import "ADDetailViewController.h"

@implementation DailyCell
{
    __weak IBOutlet UILabel *_specialGoodsTitle;
    __weak IBOutlet UIImageView *_specialGoodsImg;
    __weak IBOutlet UILabel *_specialGoodsPrice;
    __weak IBOutlet UILabel *_firstGoodsLabel;
    __weak IBOutlet UILabel *_firstGoodsTitle;
    __weak IBOutlet UIImageView *_firstGoodsImg;
    __weak IBOutlet UIImageView *_oneHourGoodsImg;
    __weak IBOutlet UILabel *_oneHourGoodsLabel;
    __weak IBOutlet UILabel *_oneHourGoodsTitle;
    
    __weak IBOutlet UIImageView *_leftView;
    __weak IBOutlet UIView *_rightUpView;
    __weak IBOutlet UIView *_rightDownView;
}

- (void)setDailyData:(NSArray *)dailyData {
    if (_dailyData != dailyData) {
        _dailyData = dailyData;
        
        _specialGoodsTitle.text = ((DailyModel *)_dailyData[0]).Title;
        [_specialGoodsImg sd_setImageWithURL:[NSURL URLWithString:((DailyModel *)_dailyData[0]).CoverUrl]];
        _specialGoodsPrice.text = ((DailyModel *)_dailyData[0]).Price;
        
        _firstGoodsTitle.text = ((DailyModel *)_dailyData[1]).Title;
        _firstGoodsLabel.text = ((DailyModel *)_dailyData[1]).Label;
        [_firstGoodsImg sd_setImageWithURL:[NSURL URLWithString:((DailyModel *)_dailyData[1]).CoverUrl]];
        
        _oneHourGoodsTitle.text = ((DailyModel *)_dailyData[2]).Title;
        _oneHourGoodsLabel.text = ((DailyModel *)_dailyData[2]).Label;
        [_oneHourGoodsImg sd_setImageWithURL:[NSURL URLWithString:((DailyModel *)_dailyData[2]).CoverUrl]];
    }
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _leftView.userInteractionEnabled = YES;
    [_leftView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(left)]];
}

- (void)left {
    ADDetailViewController *adDetail = [[ADDetailViewController alloc] init];
    adDetail.adID = @"227";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:adDetail];
    
    [self.ViewController presentViewController:nav animated:YES completion:NULL];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
