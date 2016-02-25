//
//  PeopleCell.h
//  好豆菜谱ZN
//
//  Created by Macx on 16/2/22.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopModel.h"
#import "PeopleModel.h"

@interface PeopleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;

@property (copy, nonatomic) TopModel *model;
@property (copy, nonatomic) PeopleModel *peopleModel;


@end
