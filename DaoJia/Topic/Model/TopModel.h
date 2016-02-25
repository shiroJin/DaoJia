//
//  TopModel.h
//  好豆菜谱ZN
//
//  Created by Macx on 16/2/21.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"


//"hot": [{
//    "TopicId": 426624,
//    "Img": "http:\/\/img3.hoto.cn\/group\/201602\/19\/5996356_49333240.mobile.jpg",
//    "Title": "给老妈的生日蛋糕——栗蓉坚果可可蛋糕",
//    "Avatar": "http:\/\/avatar0.hoto.cn\/44\/7f\/5996356_185.jpg?v=5",
//    "UserName": "麦子老妈",
//    "UserId": 5996356,
//    "TagName": "",
//    "TagId": 0,
//    "PreviewContent": "大年初七是我家老妈生日，做蛋糕是必须的，就是老妈不喜欢浓郁的奶油味，所以我做过抹茶慕斯，椰子味的，今年决定做个栗",
//    "CommentCount": 56,
//    "DigCount": 14,
//    "Vip": 1,
//    "Url": "haodourecipe:\/\/haodou.com\/opentopic\/?url=http%3A%2F%2Fm.haodou.com%2Ftopic-426624.html%3F_v%3Dnohead&id=426624"
//}

@interface TopModel :BaseModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *imaUrl;
@property (nonatomic, assign) NSInteger topicId;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString *previewContent;



//people

//"Img": "http:\/\/recipe1.hoto.cn\/pic\/recipe\/g_230\/2b\/f6\/390699_9a77fb.jpg",
//"Title": "红烧肉",
//"Desc": "过年的时候今年我家还真没有做那些很油腻的菜，这个红烧肉本来节前就要做这个吃的，但是忙来忙去的也没有做成，这几天想起来这个红烧肉了，就打开冰箱找出节前处理干净的五花肉，准备今晚就做这个红烧肉了。经常吃清淡的偶尔也会想年香香的肉肉了。",
//"TagName": "春节",
//"TagId": 416,
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *intro;

@property (nonatomic, copy) NSDictionary *commonInfo;

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









@end
