//
//  KitchenTableView.h
//  项目三首页
//
//  Created by mac on 16/2/15.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KitchenTableViewCell.h"

@interface KitchenTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSDictionary *dataDic;

@end
