//
//  TopicCell.h
//  好豆菜谱ZN
//
//  Created by Macx on 16/2/21.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopModel.h"

@interface TopicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *UseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ContentLable;


@property (copy, nonatomic) TopModel *topModel;



@end
