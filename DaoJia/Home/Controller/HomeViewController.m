//
//  HomeViewController.m
//  项目三首页
//
//  Created by mac on 16/2/9.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "HomeViewController.h"
#import "AFNetworking.h"
#import "HomeTableView.h"

@interface HomeViewController ()

@property (nonatomic, copy) NSDictionary *jsonData;
@property (nonatomic, strong) HomeTableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createTableView];
    [self _requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_createTableView {

    _tableView = [[HomeTableView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];

    [self.view addSubview:_tableView];
}

- (void)_requestData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSString *str = [kUrlString stringByAppendingString:[NSString stringWithFormat:@"&method=%@", homeDataMethod]];
    
    __weak typeof(_tableView) weakTableView = _tableView;
    [manager POST:str parameters:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        weakTableView.dataDic = responseObject[@"result"];
        
        [weakTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败");
        
    }];
}















- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
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
