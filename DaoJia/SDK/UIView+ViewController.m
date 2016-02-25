
//
//  UIView+ViewController.m
//  DaoJia
//
//  Created by Macx on 16/2/15.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

- (UIViewController *)ViewController {
    UIResponder *responder = self.nextResponder;
    while (![responder isKindOfClass:[UIViewController class]]) {
        if ([responder isKindOfClass:[UIWindow class]]) {
            return nil;
        }
        responder = responder.nextResponder;
    }
    
    return (UINavigationController *)responder;

}

@end
