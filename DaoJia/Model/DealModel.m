//
//  DealModel.m
//  BaiduAPIRequest
//
//  Created by Macx on 16/2/13.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "DealModel.h"

@implementation DealModel

- (void)setAttributes:(NSDictionary *)jsonDic {
    [super setAttributes:jsonDic];
    
    NSMutableArray *arr = [jsonDic objectForKey:@"shops"];
    if (arr.count > 0) {
        NSDictionary *dic = arr[0];
        self.shop = [[ShopModel alloc] initContentWithDic:dic];        
    }
}

@end
