//
//  PeopleTableView.h
//  好豆菜谱ZN
//
//  Created by Macx on 16/2/22.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSMutableDictionary *dataDictionary;


@end
