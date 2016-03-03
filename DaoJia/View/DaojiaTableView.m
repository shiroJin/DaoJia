//
//  DaojiaTableView.m
//  DaoJia
//
//  Created by Macx on 16/2/9.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "DaojiaTableView.h"
#import "CycleScrollerView.h"
#import "AdModel.h"
#import "ScrollerCell.h"
#import "DailyCell.h"
#import "GuangguangCell.h"
#import "DaojiaHeadView.h"
#import "GoodsDetailController.h"
#import "UIView+ViewController.h"
#import "GuangguangStoreModel.h"

#define kScrollerCell @"scrollerCell"
#define kGuangguangCell @"GuangguangCell"
#define kDailyCell  @"dailyCell"

@implementation DaojiaTableView

#pragma mark - 初始化方法

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        //初始化设置
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerClass:[ScrollerCell class] forCellReuseIdentifier:kScrollerCell];
        [self registerNib:[UINib nibWithNibName:@"DailyCell" bundle:nil] forCellReuseIdentifier:kDailyCell];
        [self registerNib:[UINib nibWithNibName:@"GuangguangCell" bundle:nil] forCellReuseIdentifier:kGuangguangCell];
    }
    return self;
}

- (void)setData:(NSMutableDictionary *)data {
    if (_data != data) {
        _data = data;
        [self reloadData];
    }
}

#pragma mark - 表视图代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    else if (section == 1) {
        return ((NSArray *)_data[@"guangguangStore"]).count;
    }
    else return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return kScreenWidth / 3;
    }
    return 240;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        DaojiaHeadView *headView = [[DaojiaHeadView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
        headView.title = @"逛逛";
        headView.iconImgName = @"ico_auxiliary_walking";
        return headView;
    }else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ScrollerCell *scroller = [self dequeueReusableCellWithIdentifier:kScrollerCell forIndexPath:indexPath];
            scroller.adArr = self.data[@"ad"];
            return scroller;
        }else {
            DailyCell *daily = [self dequeueReusableCellWithIdentifier:kDailyCell forIndexPath:indexPath];
            daily.dailyData = self.data[@"daily"];
            return daily;
        }
    }
    else if (indexPath.section == 1) {
        GuangguangCell *guangguangCell = [self dequeueReusableCellWithIdentifier:kGuangguangCell];
        guangguangCell.model = [self.data[@"guangguangStore"] objectAtIndex:indexPath.row];
        return guangguangCell;
    }
    else return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        GoodsDetailController *goodsDetail = [[GoodsDetailController alloc] init];
        goodsDetail.goodsId = ((GuangguangStoreModel *)[self.data[@"guangguangStore"] objectAtIndex:indexPath.row]).GoodsId;
        [self.navigationController pushViewController:goodsDetail animated:YES];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
