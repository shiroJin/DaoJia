//
//  SearchViewController.m
//  DaoJia
//
//  Created by Macx on 16/2/19.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableView.h"
#import "DealModel.h"
#import "AroundMapViewController.h"
#import "QRScannerViewController.h"

#define kTextFieldWidth 200
#define kSearchRadius 5
#define kSearchViewWidth (kScreenWidth - 50)

@interface SearchViewController () <UITextFieldDelegate>
{
    UITextField *_textField;
    SearchTableView *_tableView;
    NSMutableArray *_deals;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createBackButton];
    [self createSearchView];
    [self createMapBtn];
    [self createCRScannerBtn];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(search) name:UITextFieldTextDidChangeNotification object:nil];
}

//地图
- (void)createMapBtn {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 100, 100, 100);
    [button setTitle:@"看看周边" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(showMap) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showMap {
    AroundMapViewController *aroundMap = [[AroundMapViewController alloc] init];
    aroundMap.longitude = self.longitude;
    aroundMap.latitude = self.latitude;
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:aroundMap];
    [self presentViewController:navi animated:YES completion:NULL];
}

- (void)createCRScannerBtn {
    //扫码
    UIButton *coderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    coderBtn.frame = CGRectMake(150, 100, 100, 100);
    [coderBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    coderBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:coderBtn];
    [coderBtn addTarget:self action:@selector(coderScanner) forControlEvents:UIControlEventTouchUpInside];
}

- (void)coderScanner {
    QRScannerViewController *scanner = [[QRScannerViewController alloc] init];
    [self presentViewController:scanner animated:YES completion:NULL];
}

#pragma mark - 搜索视图
- (void)createSearchView {
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth - 60, 30)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.placeholder = @"想要搜索的团单";
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    _textField.returnKeyType = UIReturnKeySearch;
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_header_search"]];
    _textField.leftView = img;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.delegate = self;
    [_textField becomeFirstResponder];
    [self.view addSubview:_textField];
}

//返回按钮
- (void)createBackButton {
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [back setTitle:@"取消" forState:UIControlStateNormal];
    back.frame = CGRectMake(kScreenWidth - 40, 20, 30, 30);
    back.layer.cornerRadius = 10;
    [back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:back];
}

//文本框代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_textField resignFirstResponder];
    //do something
    [self search];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (_tableView) {
        _tableView.deals = nil;
        [_tableView removeFromSuperview];
    }
}

//搜索
- (void)search {
    NSString *searchContent = _textField.text;
    
    NSDictionary *params = @{
                             @"city_id" : @"600010000",
                             @"cat_ids" : @"326",
                             @"keyword" : searchContent,
                             };
    
    [RequestManager requestNuomiWithURL:@"http://apis.baidu.com/baidunuomi/openapi/searchdeals" params:[params mutableCopy] success:^(id result) {
        [self parseResult:result];
    }];
    
}
//返回
- (void)backAction {
    [_textField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - 创建表视图
- (void)createTableView {
    _tableView = [[SearchTableView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight - 50) style:UITableViewStylePlain];
}


- (void)parseResult:(id)result {
    if (!_deals) {
        _deals = [NSMutableArray array];
    }
    
    if (![result[@"errno"]  isEqual: @0]) {
        return;
    }
    
    NSDictionary *resultDic = result[@"data"];
    NSArray *arr = resultDic[@"deals"];
    //搜索结果为空时。
    if (arr.count == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NULL message:@"搜索结果为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:NULL];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:NULL];
    }
    
    for (NSDictionary *dic in arr) {
        DealModel *deal = [[DealModel alloc] initContentWithDic:dic];
        [_deals addObject:deal];
    }
    
    if (!_tableView) {
        [self createTableView];
    }
    
    [self.view addSubview:_tableView];
    _tableView.deals = _deals;
    [_tableView reloadData];
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
