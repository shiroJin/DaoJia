//
//  KitchenTableView.m
//  项目三首页
//
//  Created by mac on 16/2/15.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "KitchenTableView.h"
#import "TopicViewController.h"
#import "BasicNaviController.h"
#import "AlbumInfoViewController.h"

#define kKitchenTableViewCell @"kitchenTableViewCell"

@interface KitchenTableView ()

@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation KitchenTableView

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
        self.dataArray = [NSArray array];
        
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorInset = UIEdgeInsetsMake(0, -100, 0, 0);
        
        [self registerNib:[UINib nibWithNibName:@"KitchenTableViewCell" bundle:NULL] forCellReuseIdentifier:kKitchenTableViewCell];
        
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic {
    
    if (_dataDic != dataDic) {
        _dataDic = dataDic;
        
        _dataArray = _dataDic[@"list"];
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KitchenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kKitchenTableViewCell forIndexPath:indexPath];
    
    cell.model = [[ListModel alloc] initContentWithDic:_dataArray[indexPath.row]];
    
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    
//    cell.backgroundColor = [UIColor colorWithRed:randColorNumber green:randColorNumber blue:randColorNumber alpha:1];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([self.ViewController.title isEqualToString:@"厨房宝典"]) {
        ListModel *model = [[ListModel alloc] initContentWithDic:_dataArray[indexPath.row]];
        
        TopicViewController *view = [[TopicViewController alloc] init];
        
        view.urlString = model.url;
        
        BasicNaviController *navi = [[BasicNaviController alloc] initWithRootViewController:view];
        
        
        [self.ViewController presentViewController:navi animated:YES completion:NULL];
    }else if ([self.ViewController.title isEqualToString:@"专辑"]) {
    
        ListModel *model = [[ListModel alloc] initContentWithDic:_dataArray[indexPath.row]];
        
        AlbumInfoViewController *view = [[AlbumInfoViewController alloc] init];
        
        view.ablumID = model.idNum;
    
        BasicNaviController *navi = [[BasicNaviController alloc] initWithRootViewController:view];
        
        [self.ViewController presentViewController:navi animated:YES completion:NULL];
    
    }
    
    
}



@end
