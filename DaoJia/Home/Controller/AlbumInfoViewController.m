//
//  AlbumInfoViewController.m
//  项目三首页
//
//  Created by mac on 16/2/13.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "AlbumInfoViewController.h"

@interface AlbumInfoViewController ()

@property (nonatomic, strong) AblumTableView *tableView;

@end

@implementation AlbumInfoViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _tableView = [[AblumTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        
        [self.view addSubview:_tableView];
        
    }
    return self;
}

- (void)backAction:(UIButton *)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor orangeColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"btn_header_back"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];


}

- (void)setAblumID:(NSInteger)ablumID {
    
    if (_ablumID != ablumID) {
        _ablumID = ablumID;
        
        [self _requestData];
    }
    
}

- (void)_requestData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSString *str = [kUrlString stringByAppendingString:[NSString stringWithFormat:@"&method=%@", recipeDetailMethod]];

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    NSString *aidStr = [NSString stringWithFormat:@"%ld", self.ablumID];
    
    [dic setObject:@"10" forKey:@"limit"];
    [dic setObject:aidStr forKey:@"aid"];

    __weak typeof(_tableView) weakTableView = _tableView;
    [manager POST:str parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        weakTableView.dataDic = responseObject[@"result"];

        [weakTableView reloadData];

        //NSLog(@"%@", responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败");
        
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
