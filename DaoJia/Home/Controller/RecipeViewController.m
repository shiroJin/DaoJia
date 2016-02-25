//
//  RecipeViewController.m
//  项目三首页
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "RecipeViewController.h"

@interface RecipeViewController ()

@property (nonatomic, strong) RecipeTableView *tableView;

@end

@implementation RecipeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _tableView = [[RecipeTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        
        //[self.view addSubview:_tableView];
        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
//        
//        imageView.image = [UIImage imageNamed:@"image_pre_bigView.jpg"];
//        
//        [self.view addSubview:imageView];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setRecipeID:(NSInteger)recipeID {
    
    if (_recipeID != recipeID) {
        _recipeID = recipeID;
        
        [self _requestData];
    }

}

- (void)_requestData {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *str = [kUrlString stringByAppendingString:[NSString stringWithFormat:@"&method=%@", recipeDataMethod]];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    NSString *aidStr = [NSString stringWithFormat:@"%ld", self.recipeID];
    
//    [dic setObject:@"10" forKey:@"limit"];
    [dic setObject:aidStr forKey:@"rid"];
    
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
