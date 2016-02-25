//
//  ReadTableView.h
//  项目三首页
//
//  Created by mac on 16/2/15.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsTableViewCell.h"

@interface ReadTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *dataArray;

@end
