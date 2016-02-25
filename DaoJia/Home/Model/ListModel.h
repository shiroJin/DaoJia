//
//  ListModel.h
//  项目三首页
//
//  Created by mac on 16/2/9.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "BaseModel.h"
#import "TagModel.h"

@interface ListModel : BaseModel

//UserId": 4014,
//"Title": "榛子巧克力",
//"Cover": "http:\/\/recipe1.hoto.cn\/pic\/recipe\/l\/42\/79\/32965_z06Hh.jpg",
//"LikeCount": 758,
//"ViewCount": 9283,
//"RecipeId": 32965,
//"UserName": "飞雪无霜",
//"Intro": "推荐理由:给你我最忠贞的爱，就让这榛子巧克力带我表达。情人节快乐。",
//"Stuff": "榛子, 巧克力, 椰丝, 油, 盐",
//"IsLike": 0,
//"HasVideo": 0,
//"Duration": "",
//"Collection": "758喜欢   9283浏览"


@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger cateId;
@property (nonatomic, assign) NSInteger recipeId;
@property (nonatomic, copy) NSString *cateName;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, assign) BOOL hasVideo;
@property (nonatomic, assign) BOOL isLike;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic, assign) NSInteger recipeID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *collection;
@property (nonatomic, copy) NSString *stuff;

@property (nonatomic, assign) NSInteger idNum;

@property (nonatomic, assign) NSInteger modelId;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, assign) BOOL hasUrl;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSMutableArray *tags;

@end
