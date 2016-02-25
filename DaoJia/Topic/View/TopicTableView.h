//
//  TopicTableView.h
//  好豆菜谱ZN
//
//  Created by Macx on 16/2/19.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopModel.h"

@interface TopicTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSMutableDictionary *dataDictionary;
@property (nonatomic, copy) NSMutableDictionary *scrollerDataDic;

@end
