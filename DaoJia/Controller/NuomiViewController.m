//
//  NuomiViewController.m
//  DaoJia
//
//  Created by Macx on 16/2/15.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "NuomiViewController.h"
#import "DealDetailController.h"
#import "DealModel.h"
#import "DealCell.h"
#import "CatHeadView.h"
#import "FeHandwriting.h"

@interface NuomiViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation NuomiViewController
{
    UITableView *_tableView;
    NSMutableArray *_data;
    NSArray *_cities;//城市列表
    NSString *_cityId;
    NSString *_subcatId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.subcat;
    // Do any additional setup after loading the view.
    FeHandwriting *handWriting = [[FeHandwriting alloc] initWithView:self.view];
    [self.view addSubview:handWriting];
    [handWriting showWhileExecutingBlock:^{
        [self cityList];
    } completion:^{
        [handWriting dismiss];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *)subDealList {
    NSDictionary *subDealList = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SubDealList" ofType:@"plist"]];
    return subDealList;
}


#pragma mark - 获取城市列表
- (void)cityList {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *arr = [defaults objectForKey:@"cities"];
    if (arr) {
        _cities = arr;
        [self getCityId:self.currentCity];
        [self request];
    }else
    {
        [RequestManager requestNuomiWithURL:@"http://apis.baidu.com/baidunuomi/openapi/cities" params:NULL success:^(id result) {
            //存储数据
            NSArray *cities = result[@"cities"];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            if (defaults) {
                [defaults setObject:_cities forKey:@"cities"];
                [defaults synchronize];
            }
            
            _cities = cities;
            [self getCityId:self.currentCity];
            [self request];
        }];
    }
}

- (void)getCityId:(NSString *)city {
    for (NSDictionary *dic in _cities) {
        if ([city isEqualToString:dic[@"city_name"]]) {
            _cityId = [dic[@"city_id"] stringValue];
            return;
        }
    }
}

#pragma mark - 数据请求、解析
- (void)request {
    
    _subcatId = [self subDealList][_subcat];
    NSDictionary *params = @{
                             @"city_id" : _cityId,
                             @"cat_ids" : @"326",
                             @"subcat_ids" : _subcatId,
                             };
    
    [RequestManager requestNuomiWithURL:@"http://apis.baidu.com/baidunuomi/openapi/searchdeals" params:[params mutableCopy]  success:^(id result) {
                                                                                          [self parseResult:result];
                                                                                      }];
}

- (void)parseResult:(id)result {
    if (!_data) {
        _data = [NSMutableArray array];
    }
    if (!_tableView) {
        _tableView = [self tableView];
    }
    
    NSDictionary *resultDic = result[@"data"];
    NSArray *arr = resultDic[@"deals"];
    for (NSDictionary *dic in arr) {
        DealModel *deal = [[DealModel alloc] initContentWithDic:dic];
        [_data addObject:deal];
    }
    [_tableView reloadData];
    [_tableView.pullToRefreshView stopAnimating];
}

#pragma mark - 创建表视图
- (UITableView *)tableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"DealCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    __weak typeof(self) wself = self;
    [_tableView addPullDownRefreshBlock:^{
        [wself request];
    }];
    
    return _tableView;
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DealCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = _data[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DealDetailController *dealDetail = [[DealDetailController alloc] init];
    dealDetail.deal = _data[indexPath.row];
    [self.navigationController pushViewController:dealDetail animated:YES];
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
