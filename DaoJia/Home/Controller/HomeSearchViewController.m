//
//  HomeSearchViewController.m
//  DaoJia
//
//  Created by mac on 16/2/23.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "HomeSearchViewController.h"
#import "KitchenTableView.h"

#define searchGetSuggestion @"Search.getSuggestion"
#define searchGetList @"Search.getList"

@interface HomeSearchViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UITextField *_textField;
    UITableView *_tableView;
    NSArray *_dataArray;
    KitchenTableView *_dataTableView;
}
@end

@implementation HomeSearchViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createBackButton];
    [self createSearchView];
    
    self.title = @"搜索";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth, kScreenHeight - 70) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(search) name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark - 搜索视图
- (void)createSearchView {
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth - 60, 30)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.placeholder = @"搜索菜谱、专辑、豆友";
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




//搜索
- (void)search {
    _tableView.hidden = NO;
    _dataTableView.hidden = YES;
    
    NSString *searchContent = _textField.text;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *str = [kUrlString stringByAppendingString:[NSString stringWithFormat:@"&method=%@", searchGetSuggestion]];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    //NSString *aidStr = [NSString stringWithFormat:@"%ld", self.recipeID];
    
        [dic setObject:searchContent forKey:@"keyword"];
    //[dic setObject:[NSString stringWithFormat:@"%ld", (long)self.idnum] forKey:@"id"];
    
    __weak typeof(_tableView) weakTableView = _tableView;
    [manager POST:str parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        _dataArray = responseObject[@"result"][@"list"];
        
        [weakTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败");
        
    }];
    
}
//返回
- (void)backAction {
    [_textField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    
    imageView.image = [UIImage imageNamed:@"ico_cell_search"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, kScreenWidth - 50, 30)];
    
    label.text = _dataArray[indexPath.row];
    label.font = [UIFont systemFontOfSize:15];
    
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:label];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self searchData:_dataArray[indexPath.row]];

    tableView.hidden = YES;
}

- (void)searchData:(NSString *)keyBoard {

    if (!_dataTableView) {
        _dataTableView = [[KitchenTableView alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth, kScreenHeight - 70) style:UITableViewStylePlain];
        
        [self.view addSubview:_dataTableView];
    }
    
    _dataTableView.hidden = NO;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *str = [kUrlString stringByAppendingString:[NSString stringWithFormat:@"&method=%@", searchGetList]];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    //NSString *aidStr = [NSString stringWithFormat:@"%ld", self.recipeID];
    
    [dic setObject:keyBoard forKey:@"keyword"];
    //[dic setObject:[NSString stringWithFormat:@"%ld", (long)self.idnum] forKey:@"id"];
    
    __weak typeof(_dataTableView) weakTableView = _dataTableView;
    [manager POST:str parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _dataTableView.dataDic = responseObject[@"result"];
        
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
