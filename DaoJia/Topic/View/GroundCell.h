//
//  GroundCell.h
//  好豆菜谱ZN
//
//  Created by Macx on 16/2/21.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroundModel.h"

@interface GroundCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *TodayLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (copy, nonatomic) GroundModel *groundModel;

@end
