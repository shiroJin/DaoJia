//
//  DaojiaNavigationController.m
//  DaoJia
//
//  Created by Macx on 16/2/8.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "DaojiaNavigationController.h"

@interface DaojiaNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation DaojiaNavigationController

- (void)loadView {
    [super loadView];
    //添加手势
    id target = self.interactivePopGestureRecognizer.delegate;
    SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:internalAction];
    [self.view addGestureRecognizer:panGesture];
    panGesture.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

#pragma mark - Pan Gesture Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}

#pragma mark - Navigation Pop and Push

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:YES];
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
