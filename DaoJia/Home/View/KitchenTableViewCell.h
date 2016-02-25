//
//  KitchenTableViewCell.h
//  项目三首页
//
//  Created by mac on 16/2/15.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"

@interface KitchenTableViewCell : UITableViewCell

@property (nonatomic, strong) ListModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;


@end
