//
//  DealDetailTable.h
//  BaiduAPIRequest
//
//  Created by Macx on 16/2/13.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealDetailTable : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy)NSDictionary *data;

@end
