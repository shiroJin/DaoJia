//
//  QRScannerViewController.m
//  DaoJia
//
//  Created by Macx on 16/2/20.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "QRScannerViewController.h"
#import "QRScanner.h"

@interface QRScannerViewController () <QRCoderScannerDelegate>

@end

@implementation QRScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight)];
//    bgView.backgroundColor = [UIColor clearColor];
    QRScanner *scanner = [[QRScanner alloc] initWithView:self.view];
    scanner.delegate = self;
    [self.view addSubview:scanner];
    
    [self configBackBtn];
}

#pragma mark - 返回按钮
- (void)configBackBtn {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 20, 40, 40);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"ico_back_arrow"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:button];
}
- (void)back {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - 扫码代理
- (void)didFinshedScanningQRCode:(NSString *)result {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:result]];
    [self dismissViewControllerAnimated:YES completion:NULL];
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
