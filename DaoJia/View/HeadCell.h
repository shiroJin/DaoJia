//
//  HeadCell.h
//  BaiduAPIRequest
//
//  Created by Macx on 16/2/13.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadCell : UITableViewCell

@property (nonatomic, copy)NSString *imgUrl;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)NSNumber *sale_num;
@property (nonatomic, copy)NSString *longTitle;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIView *bottomView;


@end
