//
//  UIView+NavigationController.m
//  DaoJia
//
//  Created by Macx on 16/2/11.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "UIView+NavigationController.h"

@implementation UIView (NavigationController)

- (UINavigationController *)navigationController {
    UIResponder *responder = self.nextResponder;
    
    while (![responder isKindOfClass:[UINavigationController class]]) {
        if ([responder isKindOfClass:[UIWindow class]]) {
            return nil;
        }
        responder = responder.nextResponder;
    }
    
    return (UINavigationController *)responder;
}

@end
