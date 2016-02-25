//
//  MyCellTableView.m
//  WODE菜谱
//
//  Created by Macx on 16/2/21.
//  Copyright © 2016年 Ryan陈凯. All rights reserved.
//

#import "MyCellTableView.h"
#import "MySmallCell.h"

#define kMySmallCell @"mySmallCell"

@implementation MyCellTableView

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
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.scrollEnabled = NO;
        //注册单元格
        [self registerNib:[UINib nibWithNibName:@"MySmallCell" bundle:NULL] forCellReuseIdentifier:kMySmallCell];
        
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray {

    if (_dataArray != dataArray) {
        _dataArray = dataArray;
    }
    
    [self reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([self.dataArray[indexPath.row][@"title"] isEqualToString:@"清理缓存"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"清空缓存" message:@"确实要清空缓存吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[SDImageCache sharedImageCache] clearDisk];
        
    }
    
    [self reloadData];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MySmallCell *cell = [tableView dequeueReusableCellWithIdentifier:kMySmallCell forIndexPath:indexPath];
    
    cell.dataDic = [_dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}

@end
