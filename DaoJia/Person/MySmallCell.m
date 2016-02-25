//
//  MySmallCell.m
//  WODE菜谱
//
//  Created by Macx on 16/2/21.
//  Copyright © 2016年 Ryan陈凯. All rights reserved.
//

#import "MySmallCell.h"

@implementation MySmallCell
{

    __weak IBOutlet UIImageView *MyCellImage;
    
    __weak IBOutlet UILabel *MyCellLable;
    
}

- (void)awakeFromNib {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataDic:(NSDictionary *)dataDic {

    if (_dataDic != dataDic) {
        _dataDic = dataDic;
        
    }
    
    MyCellImage.image = [UIImage imageNamed:_dataDic[@"img"]];
    MyCellLable.text = _dataDic[@"title"];
    
    if ([_dataDic[@"title"] isEqualToString:@"清理缓存"]) {
        NSUInteger fileSize = [[SDImageCache sharedImageCache] getSize];
        NSString *text = [NSString stringWithFormat:@"%.1f M", fileSize / 1024 / 1024.0];
        
        MyCellLable.text = [MyCellLable.text stringByAppendingString:text];
    }
}

@end
