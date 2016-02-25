//
//  DealDetailController.m
//  BaiduAPIRequest
//
//  Created by Macx on 16/2/13.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "DealDetailController.h"
#import "DealDetailTable.h"
#import "FeHandwriting.h"
#import "DealModel.h"
#import "MapViewController.h"

@interface DealDetailController ()
{
    DealDetailTable *_tableView;
}

@end

@implementation DealDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavbar];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    FeHandwriting *handWriting = [[FeHandwriting alloc] initWithView:self.view];
    [self.view addSubview:handWriting];
    [handWriting showWhileExecutingBlock:^{
        [self requestData];
    } completion:^{
        [handWriting dismiss];
    }];
}

#pragma mark - 配置导航栏
- (void)configNavbar {
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.hidesBackButton = YES;
    //返回
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 20, 40);
    [button setImage:[UIImage imageNamed:@"ico_back_arrow"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    //地图
    UIButton *mapBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    mapBtn.frame = CGRectMake(0, 0, 40, 40);
    [mapBtn setImage:[UIImage imageNamed:@"bg_ico_carriage"] forState:UIControlStateNormal];
    [mapBtn addTarget:self action:@selector(showMap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mapItem = [[UIBarButtonItem alloc] initWithCustomView:mapBtn];
    self.navigationItem.rightBarButtonItem = mapItem;
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showMap {
    MapViewController *mapView = [[MapViewController alloc] init];
    mapView.deal = self.deal;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mapView];
    [self presentViewController:nav animated:YES completion:NULL];
    
}


#pragma mark - 请求数据
- (void)requestData {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                  @"deal_id" : [NSString stringWithFormat:@"%@", self.deal.deal_id],
                                                                                  }];
    [RequestManager requestNuomiWithURL:@"http://apis.baidu.com/baidunuomi/openapi/dealdetail" params:params success:^(id result) {
        [self parseResult:result];
    }];
}

- (void)parseResult:(id)result {
    NSDictionary *dic = result[@"deal"];
    [self tableView].data = dic;
}

#pragma mark - 加载表视图
- (DealDetailTable *)tableView {
    if (!_tableView) {
        _tableView = [[DealDetailTable alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
        [self.view addSubview:_tableView];
    }
    return _tableView;
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
