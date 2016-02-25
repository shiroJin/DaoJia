//
//  TabBarItem.h
//  标签栏
//
//  Created by Macx on 16/2/12.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarItem : UIControl

@property (nonatomic, copy)NSString *imgName;
@property (nonatomic, copy)NSString *selectedImgName;
@property (nonatomic, copy)NSString *title;

@end
