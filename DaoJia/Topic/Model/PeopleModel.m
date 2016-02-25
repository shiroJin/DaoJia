//
//  PeopleModel.m
//  好豆菜谱ZN
//
//  Created by Macx on 16/2/22.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "PeopleModel.h"

@implementation PeopleModel

- (void)setAttributes:(NSDictionary *)jsonDic {
    
    [super setAttributes:jsonDic];
    
  
    _desc = [jsonDic objectForKey:@"Desc"];
    _imaUrl = [jsonDic objectForKey:@"Img"];
    _title = [jsonDic objectForKey:@"Title"];
    
    
    
}

@end
