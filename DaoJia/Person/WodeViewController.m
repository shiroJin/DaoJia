//
//  WodeViewController.m
//  WODE菜谱
//
//  Created by Macx on 16/2/21.
//  Copyright © 2016年 Ryan陈凯. All rights reserved.
//

#import "WodeViewController.h"
#import "WodeTableView.h"
#import "Common.h"
@interface WodeViewController ()
{
    WodeTableView *tableView;//表视图

}

@end

@implementation WodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人";
    
    [self _createTableView];
    [self configNavgationBarItem];

    
}
//创建表示图
- (void)_createTableView{
    
    tableView = [[WodeTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    
}
#pragma mark - 导航栏标签配置
- (void)configNavgationBarItem {
    [self createRightItem];
}
//设置按钮
- (void)createRightItem {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 33, 3, 30, 30)];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_header_setup.png"]];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:label];
    self.navigationItem.rightBarButtonItem = rightItem;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
