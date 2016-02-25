//
//  AlbumTableViewCell.h
//  项目三首页
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXLabel.h"
#import "ListModel.h"

#define kLineSpace 1
#define kTextHeight 13

@interface AlbumTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;

@property (weak, nonatomic) IBOutlet UIView *imageUiView;
@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet WXLabel *introLabel;

@property (nonatomic, strong) ListModel *model;

@end
