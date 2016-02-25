//
//  LikeTableView.m
//  项目三首页
//
//  Created by mac on 16/2/15.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "LikeTableView.h"

#define kLikeTableViewCell @"likeTableViewCell"

@interface LikeTableView ()

@property (nonatomic, copy) NSArray *listArray;

@end

@implementation LikeTableView

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
        
        self.dataDic = [NSDictionary dictionary];
        
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerNib:[UINib nibWithNibName:@"AlbumTableViewCell" bundle:NULL] forCellReuseIdentifier:kLikeTableViewCell];
        
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic {
    
    if (_dataDic != dataDic) {
        _dataDic = dataDic;
        
        _listArray = dataDic[@"list"];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLikeTableViewCell forIndexPath:indexPath];
    
    cell.model = [[ListModel alloc] initContentWithDic:_listArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 150 + 20 +15;

}

@end
