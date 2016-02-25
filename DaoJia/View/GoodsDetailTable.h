//
//  GoodsDetailTable.h
//  DaoJia
//
//  Created by Macx on 16/2/15.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailModel.h"

@interface GoodsDetailTable : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)GoodsDetailModel *goods;

@end
