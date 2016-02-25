//
//  PeopleModel.h
//  好豆菜谱ZN
//
//  Created by Macx on 16/2/22.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseModel.h"

//"CommonInfo": {
//    "CommonId": 1034761,
//    "Img": "http:\/\/recipe1.hoto.cn\/pic\/recipe\/g_230\/09\/ca\/1034761_0b9869.jpg",
//    "Title": "蔓越莓花生牛轧糖-棉花糖版",
//    "Desc": "今年做了好几种口味的牛轧糖，这款是在原味的基础上加了点儿蔓越莓，吃的时候稍有些蔓越莓的酸甜，是我比较喜欢的口味~材料：花生180g，蔓越莓60g，棉花糖240g，奶粉160g，黄油45g",
//    "TagName": "糖果",
//    "TagId": 997,
//    "TagUrl": "haodourecipe:\/\/haodou.com\/recipe\/tag\/?id=997&name=%E7%B3%96%E6%9E%9C",
//    "Url": "haodourecipe:\/\/haodou.com\/Info\/getDiggCmtRewardList\/?idlist=1034761,430617,905982",
//    "HasVideo": 0
//}

@interface PeopleModel : BaseModel

@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *imaUrl;
@property (nonatomic, copy) NSString *title;


@end
