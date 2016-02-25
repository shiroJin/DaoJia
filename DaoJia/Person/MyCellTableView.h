//
//  MyCellTableView.h
//  WODE菜谱
//
//  Created by Macx on 16/2/21.
//  Copyright © 2016年 Ryan陈凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCellTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray *dataArray;

@end
