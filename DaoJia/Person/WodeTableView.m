//
//  WodeTableView.m
//  WODE菜谱
//
//  Created by Macx on 16/2/21.
//  Copyright © 2016年 Ryan陈凯. All rights reserved.
//

#import "WodeTableView.h"
#import "MyCellTableView.h"

@interface WodeTableView ()

{
    NSArray *dataArray;
    NSArray *heightArray;
}

@end

@implementation WodeTableView

#pragma mark - 初始化方法

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        //初始化设置
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        heightArray = @[@"110", @"75", @"110", @"145", @"40"];
        
        dataArray = @[//设置
                         @[
                             @{
                             @"img" : @"btn_header_setup.png" ,
                             @"title" : @"设置"
                             }
                           ],
                         //1
                         @[
                             @{
                                 @"img" : @"btn_class_recipe.png" ,
                                 @"title" : @"菜谱"
                                 },
                             @{
                                 @"img" : @"btn_class_topic.png" ,
                                 @"title" : @"话题"
                                 },
                             @{
                                 @"img" : @"btn_class_album.png" ,
                                 @"title" : @"相册"
                                 },
                             @{
                                 @"img" : @"btn_class_draft.png" ,
                                 @"title" : @"草稿"
                                 }
                             ],
                         @[
                             @{
                                 @"img" : @"ico_auxiliary_camerapo.png" ,
                                 @"title" : @"发布菜谱"
                                 },
                             @{
                                 @"img" : @"ico_auxiliary_master.png" ,
                                 @"title" : @"我的动态"
                                 },
                             @{
                                 @"img" : @"ico_auxiliary_message.png" ,
                                 @"title" : @"消息"
                                 }
                             ],
                         
                         @[
                             @{
                                 @"img" : @"ico_auxiliary_mission.png" ,
                                 @"title" : @"做任务赚豆币"
                                 },
                             @{
                                 @"img" : @"ico_auxiliary_gift_diff.png" ,
                                 @"title" : @"礼品兑换"
                                 }
                             ],
                         @[
                             @{
                                 @"img" : @"ico_auxiliary_inventory.png" ,
                                 @"title" : @"我的订单"
                                 },
                             @{
                                 @"img" : @"ico_auxiliary_inventory.png" ,
                                 @"title" : @"我的优惠券"
                                 },
                             @{
                                 @"img" : @"ico_auxiliary_inventory.png" ,
                                 @"title" : @"收货地址"
                                 }
                            
                             ],
                         @[
                             @{
                                 @"img" : @"ico_auxiliary_download.png" ,
                                 @"title" : @"我的下载"
                                 },
                             @{
                                 @"img" : @"ico_auxiliary_collection.png" ,
                                 @"title" : @"我的收藏"
                                 },
                             @{
                                 @"img" : @"ico_auxiliary_grocerylist.png" ,
                                 @"title" : @"采购清单"
                                 },
                             @{
                                 @"img" : @"ico_auxiliary_intelligence.png" ,
                                 @"title" : @"清理缓存"
                                 }
                             
                             ],
                                                       ];
        
    }

    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 4) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth, 30)];
        
        label.text = @"意见反馈";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:20];
        
        [cell addSubview:label];
        
        return cell;
    }

    
    
    CGFloat height = [[heightArray objectAtIndex:indexPath.row] floatValue];

    UITableViewCell *cell= [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    
    cell.backgroundColor= [UIColor clearColor];
    
    MyCellTableView *cellTableView = [[MyCellTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height) style:UITableViewStylePlain];
    
    cellTableView.dataArray = [dataArray objectAtIndex:indexPath.row + 2];
    
    [cell addSubview:cellTableView];
    
    [self createGrayLabelWithCell:cell withHeight:height];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [heightArray[indexPath.row] floatValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 150;
}
//top登入 头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UITableViewHeaderFooterView *headerView = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    headerView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_fill_top"]];

    CGFloat width = kScreenWidth / 4.5;
    
    NSArray *arr = @[@"登录", @"注册"];
    
    for (int i = 0; i < 2; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(width + 1.5 * width * i, 70, width, 40)];
        
        button.layer.cornerRadius = 12;
//        button.titleLabel.text = arr[i];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor orangeColor]];
        
        [headerView addSubview:button];
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 210 - 70, kScreenWidth, 70)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    NSArray *array = [dataArray objectAtIndex:1];
    
    CGFloat widthOfControl = kScreenWidth / 4;
    for (int i = 0; i < 4; i++) {
        UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(widthOfControl * i, 0, widthOfControl, 70)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(widthOfControl / 2 - 14, 10, 28, 20)];
        label.text = [array[i] objectForKey:@"title"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(widthOfControl / 2 - 12, CGRectGetMaxY(label.frame), 24, 24)];
        imageView.image = [UIImage imageNamed:[array[i] objectForKey:@"img"]];
        

        [control addSubview:imageView];
        [control addSubview:label];
        
        [view addSubview:control];
    }
    
    [headerView addSubview:view];
    
    [self createGrayLabelWithCell:headerView withHeight:210];
    
    return headerView;

}

- (void)createGrayLabelWithCell:(UITableViewCell *)cell withHeight:(CGFloat)height{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, height - 5, kScreenWidth, 5)];
    label.backgroundColor = [UIColor grayColor];
    label.alpha = 0.3;
    
    [cell addSubview:label];
    
}

@end
