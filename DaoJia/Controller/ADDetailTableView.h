//
//  ADDetailTableView.h
//  DaoJia
//
//  Created by Macx on 16/2/11.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADDetailTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy)NSString *coverUrl;
@property (nonatomic, copy)NSArray *data;

@end
