//
//  RecipeTableView.h
//  项目三首页
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSDictionary *dataDic;

@end
