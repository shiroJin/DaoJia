//
//  NewsTableView.m
//  项目三首页
//
//  Created by mac on 16/2/13.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "NewsTableView.h"
#import "TopicViewController.h"
#import "BasicNaviController.h"

#define kIdentifity @"newsTableViewCell"

@implementation NewsTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.scrollEnabled = NO;
        
        _dataArray = [NSArray array];
        
        [self registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:NULL] forCellReuseIdentifier:kIdentifity];
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifity forIndexPath:indexPath];
    
    NSDictionary *dic = _dataArray[indexPath.row];

    ListModel *model = [[ListModel alloc] initContentWithDic:dic];
    
    cell.width = tableView.width;
    cell.model = model;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    ListModel *model = [[ListModel alloc] initContentWithDic:_dataArray[indexPath.row]];

    TopicViewController *view = [[TopicViewController alloc] init];
    
    view.urlString = model.urlString;
    
    BasicNaviController *navi = [[BasicNaviController alloc] initWithRootViewController:view];
    
    [self.ViewController presentViewController:navi animated:YES completion:NULL];
    
}

@end
