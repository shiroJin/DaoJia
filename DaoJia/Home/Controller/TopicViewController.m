//
//  TopicViewController.m
//  项目三首页
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "TopicViewController.h"

@interface TopicViewController ()
{
    UIWebView *webView;
}
@end

//                "Url": "haodourecipe://haodou.com/opentopic/?url=http://m.haodou.com/topic-422021.html&id=422021"
//http://m.haodou.com/topic-422021.html?_v=nohead
@implementation TopicViewController

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
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    
    view.clipsToBounds = YES;
    
    [self.view addSubview:view];
    
    webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    webView.origin = CGPointMake(0, -44);
        //1.加载网络
    if (self.urlString) {
        NSURL *url = [NSURL URLWithString:self.urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [webView loadRequest:request];
    }else if(self.method) {
        [self _requestData];
    }
    
    [view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_requestData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *str = [kUrlString stringByAppendingString:[NSString stringWithFormat:@"&method=%@", _method]];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    //NSString *aidStr = [NSString stringWithFormat:@"%ld", self.recipeID];
    
    //    [dic setObject:@"10" forKey:@"limit"];
    [dic setObject:[NSString stringWithFormat:@"%ld", self.idnum] forKey:@"id"];
    
    __weak typeof(webView) weakWebView = webView;
    [manager POST:str parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSURL *url = [NSURL URLWithString:responseObject[@"result"][@"share_url"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [weakWebView loadRequest:request];
        
        weakWebView.origin = CGPointMake(0, 0);
        
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
