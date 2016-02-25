//
//  DaojiaTableView.h
//  DaoJia
//
//  Created by Macx on 16/2/9.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaojiaTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSMutableDictionary *data;

@end
