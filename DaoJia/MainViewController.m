//
//  MainViewController.m
//  标签栏
//
//  Created by Macx on 16/2/12.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "MainViewController.h"
#import "TabBarItem.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hidesBottomBarWhenPushed = YES;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self configTabBar];
    });
}

#pragma mark - 配置标签栏
- (void)configTabBar {
    Class cls = NSClassFromString(@"UITabBarButton");
    for (UIView *item in self.tabBar.subviews) {
        if ([item isKindOfClass:cls]) {
            [item removeFromSuperview];
        }
    }
    
    self.tabBar.backgroundColor= [UIColor whiteColor];
    [self createItems];
}
- (void)createItems {
    NSArray *titles = @[@"到家", @"菜谱", @"广场", @"我的"];
    NSArray *imgName = @[@"menu_ico_home", @"menu_ico_shop", @"menu_ico_gather", @"menu_ico_center"];
    NSArray *selectedImgName = @[@"menu_ico_home_on", @"menu_ico_shop_on", @"menu_ico_gather_on", @"menu_ico_center_on"];
    
    CGFloat width = kScreenWidth / 4;
    for (int i = 0; i < 4; i++) {
        TabBarItem *item = [[TabBarItem alloc] initWithFrame:CGRectMake(width * i, 0, width, 48)];
        item.imgName = imgName[i];
        item.selectedImgName = selectedImgName[i];
        item.title = titles[i];
        item.tag = 200 + i;
        if (i == 0) {
            item.selected = YES;
        }
        [item addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:item];
    }
}

- (void)clickAction:(UIControl *)sender {
    static NSInteger formerIndex = 200;
    
    if (sender.tag == formerIndex) {
        return;
    }
    
    UIControl *control = [self.tabBar viewWithTag:formerIndex];
    if (control) {
        control.selected = NO;
    }
    sender.selected = YES;
    self.selectedIndex = sender.tag - 200;
    formerIndex = sender.tag;
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
