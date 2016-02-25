//
//  TagModel.m
//  项目三首页
//
//  Created by mac on 16/2/15.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "TagModel.h"

@implementation TagModel

- (void)setAttributes:(NSDictionary *)jsonDic {

    [super setAttributes:jsonDic];
    
    self.tagID = [[jsonDic objectForKey:@"Id"] integerValue];;
    self.name = [jsonDic objectForKey:@"Name"];
    
}

@end
