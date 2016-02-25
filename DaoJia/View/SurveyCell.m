//
//  SurveyCell.m
//  DaoJia
//
//  Created by Macx on 16/2/15.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "SurveyCell.h"
#import "GoodsDetailModel.h"

@implementation SurveyCell
{
    __weak IBOutlet UILabel *_likeCount;
    __weak IBOutlet UILabel *_tasteCount;
    __weak IBOutlet UILabel *_buyCount;
    
}

- (void)setGoods:(GoodsDetailModel *)goods {
    if (_goods != goods) {
        _goods = goods;
        
        _likeCount.text = [NSString stringWithFormat:@"%@人想吃", _goods.LikeCount];
        _tasteCount.text = [NSString stringWithFormat:@"口味%@分", _goods.TasteCount];
        _buyCount.text = [NSString stringWithFormat:@"销量%@", _goods.BuyCount];
    }
}


- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
