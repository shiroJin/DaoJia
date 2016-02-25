//
//  TopicTableView.m
//  好豆菜谱ZN
//
//  Created by Macx on 16/2/19.
//  Copyright © 2016年 Macx. All rights reserved.


#import "TopicTableView.h"
#import "HeadSectionView.h"

#import "TopicCell.h"
#import "GroundCell.h"
#import "HomeCycleScrollView.h"


@implementation TopicTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {

//初始化设置
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSelectionStyleGray;
        [self registerNib:[UINib nibWithNibName:@"TopicCell" bundle:nil] forCellReuseIdentifier:@"top"];
        [self registerNib:[UINib nibWithNibName:@"GroundCell" bundle:nil] forCellReuseIdentifier:@"ground"];

        
    }
    return self;
}


#pragma -mark 滑动视图

- (void)configScrollerView {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    headView.backgroundColor = [UIColor yellowColor];
    self.tableHeaderView = headView;
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    self.tableFooterView = footView;
    NSArray *arr = [self.dataDictionary objectForKey:@"ad"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        
//  [array addObject:[dic objectForKey:@"Img"]];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];

//        img.image = [UIImage imageNamed:[dic objectForKey:@"Img"]];
        
        [img sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"Img"]]];
        [array addObject:img];
        
    }
    
    HomeCycleScrollView *scrollView = [[HomeCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) animationDuration:3];
    
//    __weak typeof(self) weakSelf = self;
    scrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return array[pageIndex];
    };
    
    scrollView.totalPagesCount = ^NSInteger(void){
        return array.count;
    };
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 60 , CGRectGetMaxY(scrollView.frame) - 20, 120, 20)];
    
    pageControl.numberOfPages = array.count;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    __weak typeof(pageControl) weakPageControl = pageControl;
    scrollView.changeCurrentPage = ^(NSInteger pageIndex) {
        
        weakPageControl.currentPage = pageIndex;
        
    };
    [scrollView addSubview:pageControl];
    [headView addSubview:scrollView];
    
}

#pragma -mark  表示图代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 3;
    }
    if (section == 1) {
        return 11;
    }
    if (section == 2) {
        return 1;
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
    NSArray *arr = [self.dataDictionary objectForKey:@"hot"];
    
       TopicCell *cell = [self dequeueReusableCellWithIdentifier:@"top"];
        
        if (arr.count > indexPath.row) {
            cell.topModel = [[TopModel alloc] initContentWithDic:[arr objectAtIndex:indexPath.row]];
        }
        
        return cell;
        
    }
    
    if (indexPath.section == 1) {
    NSArray *arr = [self.dataDictionary objectForKey:@"group"];
        GroundCell *cell = [self dequeueReusableCellWithIdentifier:@"ground"];
        
        if (arr.count >indexPath.row) {
            cell.groundModel = [[GroundModel alloc] initContentWithDic:[arr objectAtIndex:indexPath.row]];
        }

        
        return cell;
    }
    if (indexPath.section == 2) {

        return [self ninethCell];
        
        
    }
    
 

    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    [self configScrollerView];

    return 3;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {

        HeadSectionView *head = [[HeadSectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        head.leftImage.image = [UIImage imageNamed:@"ico_auxiliary_hotspot.png"];
        head.titleLable.text = @"实时热点";
        head.titleLable.textAlignment = NSTextAlignmentLeft;
        head.titleLable.font = [UIFont systemFontOfSize:15];
        return head;
 
    }
    if (section == 1) {
        
        HeadSectionView *head = [[HeadSectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        head.leftImage.image = [UIImage imageNamed:@"ico_auxiliary_topic.png"];
        head.titleLable.text = @"话题小组";
        head.titleLable.textAlignment = NSTextAlignmentLeft;
        head.titleLable.font = [UIFont systemFontOfSize:15];
        return head;
        
    }
    if (section == 2) {
        
        HeadSectionView *head = [[HeadSectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        head.leftImage.image = [UIImage imageNamed:@"ico_auxiliary_master.png"];
        head.titleLable.text = @"活跃豆亲";
        head.titleLable.textAlignment = NSTextAlignmentLeft;
        head.titleLable.font = [UIFont systemFontOfSize:15];
        return head;
        
    }
    
    return nil;
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footViewSec = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    footViewSec.backgroundColor = [UIColor grayColor];
    return footViewSec;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 1) {
        
        return 61;
    }
    
    return 90;
    
}


- (UITableViewCell *)ninethCell {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
     NSArray *array = [_dataDictionary objectForKey:@"todayStar"];
    
//    [self createSmallTitleWithDic:jsonData withCell:cell];
    
//    NSArray *array = jsonData[@"list"];
    
    CGFloat width = kScreenWidth / 5;
    for (int i = 0 ; i < array.count; i++) {
        
        NSDictionary *dic = array[i];
        
        TopModel *model = [[TopModel alloc] initContentWithDic:dic];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(width * i, 20, width, 50)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(button.width/ 2 - 15, 0, 30, 30)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
        
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = imageView.width / 2;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 5, button.width, 20)];
        
        titleLabel.text = model.userName;
        titleLabel.font = [UIFont systemFontOfSize:10];
        //titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [button addSubview:imageView];
        [button addSubview:titleLabel];
        [cell addSubview:button];
    }
    
    return cell;
}




@end
