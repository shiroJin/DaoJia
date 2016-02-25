//
//  BasicNaviController.m
//  项目三首页
//
//  Created by mac on 16/2/13.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "BasicNaviController.h"

@interface BasicNaviController ()

@end

@implementation BasicNaviController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, 20)];
    
    view.backgroundColor = [UIColor orangeColor];
    
    [self.navigationBar addSubview:view];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];

    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
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
