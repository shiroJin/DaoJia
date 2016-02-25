//
//  NewsTableView.h
//  项目三首页
//
//  Created by mac on 16/2/13.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsTableViewCell.h"

@interface NewsTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *dataArray;

@end
