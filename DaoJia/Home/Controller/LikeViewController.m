//
//  LikeViewController.m
//  项目三首页
//
//  Created by mac on 16/2/15.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "LikeViewController.h"

@interface LikeViewController ()

@property (nonatomic, strong) LikeTableView *tableView;

@end

@implementation LikeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _tableView = [[LikeTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        
        [self.view addSubview:_tableView];
        [self _requestData];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_requestData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *str = [kUrlString stringByAppendingString:[NSString stringWithFormat:@"&method=%@", recipeGetCollectRecomment]];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    //NSString *aidStr = [NSString stringWithFormat:@"%ld", self.ablumID];
    
    [dic setObject:@"15" forKey:@"limit"];
    [dic setObject:@"猜你喜欢" forKey:@"Title"];
    [dic setObject:@"猜你喜欢" forKey:@"type"];

    //[dic setObject:aidStr forKey:@"aid"];
    
    __weak typeof(_tableView) weakTableView = _tableView;
    [manager POST:str parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakTableView.dataDic = responseObject[@"result"];
        
        [weakTableView reloadData];
        
        //NSLog(@"%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败");
        
    }];
    
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
