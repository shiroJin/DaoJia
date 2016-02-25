//
//  DealDetailController.h
//  BaiduAPIRequest
//
//  Created by Macx on 16/2/13.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DealModel;
@interface DealDetailController : UIViewController

@property (nonatomic, strong)NSNumber *dealID;
@property (nonatomic, strong)DealModel *deal;

@end
