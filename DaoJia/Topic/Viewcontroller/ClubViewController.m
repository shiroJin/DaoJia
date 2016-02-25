//
//  ClubViewController.m
//  好豆菜谱ZN
//
//  Created by Macx on 16/2/17.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ClubViewController.h"
#import "TopicTableView.h"
#import "PeopleTableView.h"


@interface ClubViewController ()
{
    TopicTableView *topicTableView;
    PeopleTableView *peopleTableView;
}

@end

@implementation ClubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavgationBarItem];
    [self configChoiceBar];
    topicTableView = [[TopicTableView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight-44) style:UITableViewStyleGrouped];
    peopleTableView = [[PeopleTableView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight-44) style:UITableViewStylePlain];

    [self _requestData];
    [self _requestPeopleData];
    
    [self performSelector:@selector(topicClick) withObject:nil];
}

#pragma mark - 分类页面配置
- (void)configChoiceBar {
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, kScreenWidth/2, 44);
    [button setImage:[UIImage imageNamed:@"ico_class_topic_gray@2x.png"] forState:UIControlStateNormal];
    [button setTitle:@"话题" forState:UIControlStateNormal];
    button.tintColor = [UIColor grayColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(topicClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 44);
    [button2 setImage:[UIImage imageNamed:@"ico_class_people_gray@2x.png"] forState:UIControlStateNormal];
    [button2 setTitle:@"豆友" forState:UIControlStateNormal];
    button2.tintColor = [UIColor grayColor];
    [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(peopleClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    //abolish
//    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button3.frame = CGRectMake(kScreenWidth*2/3, 0, kScreenWidth/3, 44);
//    [button3 setImage:[UIImage imageNamed:@"ico_class_activity_gray@2x.png"] forState:UIControlStateNormal];
//    [button3 setTitle:@"动态" forState:UIControlStateNormal];
//    [button3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [button3 addTarget:self action:@selector(activityClick) forControlEvents:UIControlEventTouchUpInside];
////    [self.view addSubview:button3];
    
}

#pragma mark - 导航栏标签配置
- (void)configNavgationBarItem {
    [self createLeftItem];
    [self createTitleView];
    [self createRightItem];
}


- (void)createLeftItem {
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    lable.text = @"广场";
    lable.textColor = [UIColor orangeColor];
    lable.font = [UIFont fontWithName:@"ArialBoldMT" size:20];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:lable];
    self.navigationItem.leftBarButtonItem = leftItem;

}

- (void)createTitleView {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    textField.layer.cornerRadius = 5;
    textField.layer.masksToBounds = YES;
    textField.backgroundColor = [UIColor lightGrayColor];
    textField.placeholder = @"搜话题";
    self.navigationItem.titleView = textField;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)createRightItem {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0,32,32);
    [button setImage:[UIImage imageNamed:@"btn_header_edit.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;

}

#pragma mark - 分类页面配置按钮
- (void)topicClick {
    
    [peopleTableView removeFromSuperview];
    [self.view addSubview:topicTableView];
}

- (void)peopleClick {
    
    [topicTableView removeFromSuperview];
    [self.view addSubview:peopleTableView];
}

- (void)_requestData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *str = [UrlString stringByAppendingString:[NSString stringWithFormat:@"&method=%@", DataMethod]];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
      [dic setObject:@"20" forKey:@"limit"];
    
    __weak typeof(topicTableView) weakTableView = topicTableView;
    
    [manager POST:str parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakTableView.dataDictionary = responseObject[@"result"];

        [weakTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败");
        
    }];
    
}

- (void)_requestPeopleData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *str = [PeopleUrlString stringByAppendingString:[NSString stringWithFormat:@"&method=%@", PeopleDataMethod]];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //    NSString *aidStr = [NSString stringWithFormat:@"%ld", self.recipeID];
    [dic setObject:@"20" forKey:@"limit"];
    //    [dic setObject:aidStr forKey:@"rid"];
    __weak typeof(peopleTableView) weakTableView = peopleTableView;
    [manager POST:str parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        weakTableView.dataDictionary = responseObject[@"result"];
                NSLog(@"%@", responseObject);
        [weakTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败");
        
    }];
    
}





@end
