//
//  GoodsDetailController.m
//  DaoJia
//
//  Created by Macx on 16/2/15.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "GoodsDetailController.h"
#import "GoodsDetailModel.h"
#import "GoodsDetailTable.h"
#import <ShareSDK/ShareSDK.h>
#import "MBProgressHUD.h"

@interface GoodsDetailController () <UITableViewDelegate>

@end

@implementation GoodsDetailController
{
    GoodsDetailModel *_goods;
    GoodsDetailTable *_tableView;
    MBProgressHUD *_hud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view.
    FeHandwriting *handWriting = [[FeHandwriting alloc] initWithView:self.view];
    [self.view addSubview:handWriting];
    [handWriting showWhileExecutingBlock:^{
        [self request];
    } completion:^{
        [handWriting dismiss];
    }];
    [self navigationBarCustom];
}

#pragma mark - 自定义导航栏
- (void)navigationBarCustom {
    self.navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    [self.view addSubview:self.navigationBar];
    self.navigationBar.backgroundColor = [UIColor clearColor];
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 0, 40, 44);
    [backBtn setImage:[UIImage imageNamed:@"ico_back_arrow"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar addSubview:backBtn];
    //购物车
    UIButton *trolleyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    trolleyBtn.frame = CGRectMake(kScreenWidth - 40 * 2 - 30, 0, 40, 44);
    [trolleyBtn setImage:[UIImage imageNamed:@"btn_header_shoppingcart"] forState:UIControlStateNormal];
    [self.navigationBar addSubview:trolleyBtn];
    //分享
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(kScreenWidth - 40 - 10, 0, 40, 44);
    [shareBtn setImage:[UIImage imageNamed:@"btn_header_share_gray"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar addSubview:shareBtn];
    
    UIImageView *statusBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    statusBackground.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:statusBackground];
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)share {
//    id<ISSCAttachment>img = [ShareSDK imageWithUrl:_goods.CoverUrl];
    id<ISSContent>publishContent = [ShareSDK content:_goods.SubTitle
                                      defaultContent:@"默认内容"
                                               image:nil
                                               title:@"ShareSDK"
                                                 url:_goods.ShareUrl
                                         description:@"这是一条演示信息"
                                           mediaType:SSPublishContentMediaTypeNews];
    [ShareSDK showShareActionSheet:nil shareList:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        _hud = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
        _hud.mode = MBProgressHUDModeCustomView;
        
        if (state == SSResponseStateSuccess) {
            _hud.labelText = @"分享成功";
            _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
            [_hud hide:YES afterDelay:3.5];
        }else {
            _hud.labelText = @"分享失败";
            _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alert_error_icon"]];
            [_hud hide:YES afterDelay:3.5];
        }
    }];
    
}

#pragma mark - 自定义标签栏
- (void)tabBarCustom {
}



#pragma mark - 网络请求
- (void)request {
    NSDictionary *params = @{
                             @"GoodsId" : [NSString stringWithFormat:@"%@", self.goodsId],
                             @"Latitude" : @"30.98911",
                             @"Longitude" : @"120.7924",
                             @"sign" : @"",
                             @"uid" : @"",
                             @"uuid" : @"03b31d55771c2b02a638bab33220668b",
                             };
    [RequestManager requestWithURL:GoodsDetailUrl params:[params mutableCopy] success:^(id result) {
        [self parseResult:result];
    }];
}

- (void)parseResult:(id)resultData {
    NSDictionary *result = resultData[@"result"];
    _goods = [[GoodsDetailModel alloc] initContentWithDic:result];
    if (!_tableView) {
        [self tableView];
    }
    _tableView.goods = _goods;
    [_tableView reloadData];
    [_tableView.pullToRefreshView stopAnimating];
}

- (void)tableView {
    _tableView = [[GoodsDetailTable alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight - 20) style:UITableViewStylePlain];
    [self.view insertSubview:_tableView belowSubview:self.navigationBar];
    
    __weak typeof(self) wself = self;
    [_tableView addPullDownRefreshBlock:^{
        [wself request];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
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
