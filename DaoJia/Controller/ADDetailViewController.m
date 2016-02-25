//
//  ADDetailViewController.m
//  DaoJia
//
//  Created by Macx on 16/2/11.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "ADDetailViewController.h"
#import "ADGoodsModel.h"
#import "ADDetailTableView.h"

@interface ADDetailViewController ()

@end

@implementation ADDetailViewController
{
    ADDetailTableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configNavbar];
    // Do any additional setup after loading the view.
    FeHandwriting *handWriting = [[FeHandwriting alloc] initWithView:self.view];
    [self.view addSubview:handWriting];
    [handWriting showWhileExecutingBlock:^{
        [self request];
    } completion:^{
        [handWriting dismiss];
    }];

}

#pragma mark - 配置导航栏
- (void)configNavbar {
    self.navigationController.navigationBar.translucent = NO;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 20, 40);
    [button setImage:[UIImage imageNamed:@"ico_back_arrow"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
}
- (void)back {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - 请求数据
- (void)request {
    NSDictionary *params = @{
                             @"Id" : self.adID,
                             @"limit" : @"20",
                             @"offset" : @"0",
                             @"sign" : @"",
                             @"uid" : @"",
                             @"uuid" : @"03b31d55771c2b02a638bab33220668b"
                             };
    [RequestManager requestWithURL:ADUrl params:[params mutableCopy] success:^(id result) {
        [self parseResult:result];
    }];
}

#pragma mark - 解析数据
- (void)parseResult:(id)result {
    NSDictionary *resultDic = result[@"result"];
    NSString *coverUrl = resultDic[@"info"][@"CoverUrl"];
    NSString *title = resultDic[@"info"][@"Title"];
    
    NSArray *list = resultDic[@"list"];
    NSMutableArray *data = [NSMutableArray array];
    for (NSDictionary *dic in list) {
        ADGoodsModel *goods = [[ADGoodsModel alloc] initContentWithDic:dic];
        [data addObject:goods];
    }
    
    if (!_tableView) {
        [self tableView];
    }
    
    self.title = title;
    _tableView.coverUrl = coverUrl;
    _tableView.data = data;
    [_tableView reloadData];
    [_tableView.pullToRefreshView stopAnimating];
}

- (void)tableView {
    _tableView = [[ADDetailTableView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
    __weak typeof(self) wself = self;
    [_tableView addPullDownRefreshBlock:^{
        [wself request];
    }];
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
