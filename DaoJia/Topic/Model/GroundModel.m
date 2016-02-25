//
//  GroundModel.m
//  好豆菜谱ZN
//
//  Created by Macx on 16/2/21.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "GroundModel.h"

//@property (nonatomic, assign) NSInteger cateId ;
//@property (nonatomic, copy) NSString *imgUrl;
//@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *num;
//@property (nonatomic, copy) NSString *desc;
//            "Img": "http:\/\/img4.hoto.cn\/res\/images\/public\/group\/33.jpg?v=10000",
//"CateId": 33,
//"Name": "家常菜",
//"ViewDesc": "今日围观 49726",
//"Desc": "家常味道，幸福滋味",
//"Url": "haodourecipe:\/\/haodou.com\/httopic\/?id=33"

@implementation GroundModel

- (void)setAttributes:(NSDictionary *)jsonDic {
    
    [super setAttributes:jsonDic];
    
    _imgUrl = [jsonDic objectForKey:@"Img"];
    _cateId = [[jsonDic objectForKey:@"CateId"] integerValue];
    _name = [jsonDic objectForKey:@"Name"];
    _num = [jsonDic objectForKey:@"ViewDesc"];
    _desc = [jsonDic objectForKey:@"Desc"];
    
    
    
    
    
}

@end
