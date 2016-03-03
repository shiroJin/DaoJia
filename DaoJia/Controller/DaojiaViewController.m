//
//  DaojiaViewController.m
//  DaoJia
//
//  Created by Macx on 16/2/8.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "DaojiaViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "DaojiaTableView.h"
#import "RightBarItem.h"
#import "DealModel.h"
#import "AdModel.h"
#import "DailyModel.h"
#import "GuangguangStoreModel.h"
#import "NuomiViewController.h"
#import "SearchViewController.h"

@interface DaojiaViewController () <CLLocationManagerDelegate, UITextFieldDelegate>
{
    CLLocationManager *_locationManager;
    DaojiaTableView *_tableView;//表视图
    NSString *_currentCity;
    double _longitude;
    double _latitude;
}

@property (nonatomic, strong)UIView *customBar;

@end

@implementation DaojiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self customNavigationBar];
    // Do any additional setup after loading the view.
    FeHandwriting *handWriting = [[FeHandwriting alloc] initWithView:self.view];
    [self.view addSubview:handWriting];
    [handWriting showWhileExecutingBlock:^{
//        [self request];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dingwei];
            [self performSelector:@selector(request) withObject:nil afterDelay:8];
        });
    } completion:^{
        [handWriting dismiss];
    }];

}


#pragma mark - 导航栏标签配置
- (void)customNavigationBar {
    self.navigationController.navigationBarHidden = YES;
    self.customBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    [self.view addSubview:self.customBar];
    
    [self createLeftItem];
    [self createTitleView];
    [self createRightItem];
}

- (void)createLeftItem {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, 60, 44)];
    label.text = @"到家";
    label.textAlignment = NSTextAlignmentCenter;
    label.tag = 200;
    label.textColor = [UIColor orangeColor];
    label.font = [UIFont fontWithName:@"ArialBoldMT" size:20];
    [self.customBar addSubview:label];
}

- (void)createTitleView {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake((kScreenWidth - 180) / 2, 27, 180, 30)];
    textField.layer.cornerRadius = 5;
    textField.layer.masksToBounds = YES;
    textField.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    textField.placeholder = @"搜索商品";
    textField.delegate = self;
    [self.customBar addSubview:textField];
}

- (void)createRightItem {
    RightBarItem *button = [RightBarItem buttonWithType:UIButtonTypeCustom];
    //选中事件
    [button setTitleArray:[self subcatList] selectBlock:^(NSInteger selectIndex) {
        NuomiViewController *nuomi = [[NuomiViewController alloc] init];
        if (!_currentCity) {
            nuomi.currentCity = @"杭州市";
        }else {
            nuomi.currentCity = _currentCity;
        }
        
        NSString *selectSubcat = [self subcatList][selectIndex];
        nuomi.subcat = selectSubcat;
        
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:nuomi];
        [self presentViewController:navi animated:YES completion:NULL];
    }];
    
    button.frame = CGRectMake(kScreenWidth - 70, 22, 60, 40);
    [self.customBar addSubview:button];
}
//文本框代理
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    SearchViewController *search = [[SearchViewController alloc] init];
    search.longitude = _longitude;
    search.latitude = _latitude;
    [self presentViewController:search animated:YES completion:NULL];
}


#pragma mark - 定位当前城市
- (void)dingwei  {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    if ([CLLocationManager authorizationStatus]!= kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_locationManager requestWhenInUseAuthorization];
    }
    //定位的精度 double类型 精度越高越耗电
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    //定位的频率
    _locationManager.distanceFilter = 1000.0;
    //开始定位
    [_locationManager startUpdatingLocation];
}

#pragma - mark 定位代理
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    _latitude = ((CLLocation *)[locations firstObject]).coordinate.latitude;
    _longitude = ((CLLocation *)[locations firstObject]).coordinate.longitude;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:locations[0] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error||placemarks.count==0) {
            NSLog(@"%@", @"地址没找到，可能在月球上");
            [self request];
        }else//编码成功
        {
            //显示最前面的地标信息
            CLPlacemark *firstPlacemark=[placemarks firstObject];
            //配置导航栏位置信息
            UILabel *label = [self.customBar viewWithTag:200];
            NSString *city = firstPlacemark.locality;
            label.text = city;
            if (_currentCity != city) {
                NSLog(@"%@", firstPlacemark.locality);
                _currentCity = city;
                [self request];
            }
        }
    }];
    
    [_locationManager stopUpdatingLocation];
}

#pragma mark - 数据请求
- (void)request {
    [RequestManager requestWithURL:DaojiaHomeUrl params:NULL success:^(id result) {
        [self parseResult:result];
    }];
}

#pragma mark - 解析数据
- (void)parseResult:(id)result {
    NSDictionary *resultDic = result[@"result"];
    //广告数据
    NSArray *adArr = resultDic[@"ad"];
    NSMutableArray *adArray = [NSMutableArray array];
    for (NSDictionary *dic in adArr) {
        AdModel *ad = [[AdModel alloc] initContentWithDic:dic];
        [adArray addObject:ad];
    }
    //逛逛商品数据
    NSArray *listArr = resultDic[@"list"];
    NSMutableArray *storeArray = [NSMutableArray array];
    for (NSDictionary *dic in listArr) {
        GuangguangStoreModel *store = [[GuangguangStoreModel alloc] initContentWithDic:dic];
        [storeArray addObject:store];
    }
    //每日推荐数据
    NSArray *dailyNames = @[@"DailySpecialGoods", @"DailyFirstGoods", @"OneHourGoods"];
    NSMutableArray *dailyArray = [NSMutableArray array];
    for (NSString *name in dailyNames) {
        NSDictionary *dic = [resultDic objectForKey:name];
        DailyModel *daily = [[DailyModel alloc] initContentWithDic:dic];
        [dailyArray addObject:daily];
    }
    
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setValue:dailyArray forKey:@"daily"];
    [data setValue:adArray forKey:@"ad"];
    [data setValue:storeArray forKey:@"guangguangStore"];
    
    if (!_tableView) {
        [self tableView];
    }
    _tableView.data = data;
    [_tableView.pullToRefreshView stopAnimating];
}
- (NSArray *)subcatList {
    NSArray *subcatList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SubcatList" ofType:@"plist"]];
    return subcatList;
}

#pragma mark - 创建表视图
- (void)tableView {
    _tableView = [[DaojiaTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 48 - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    __weak typeof(self) wself = self;
    [_tableView addPullDownRefreshBlock:^{
        [wself request];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    self.tabBarController.tabBar.hidden = NO;
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
