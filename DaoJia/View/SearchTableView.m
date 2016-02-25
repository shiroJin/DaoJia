//
//  SearchTableView.m
//  DaoJia
//
//  Created by Macx on 16/2/19.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "SearchTableView.h"
#import "DealCell.h"

@interface SearchTableView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation SearchTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerNib:[UINib nibWithNibName:@"DealCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return self;
}

#pragma mark - 表视图代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _deals.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DealCell *cell = [self dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = self.deals[indexPath.row];
    
    return cell;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
