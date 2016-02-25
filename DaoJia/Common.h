//
//  Common.h
//  DaoJia
//
//  Created by Macx on 16/2/9.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define DaojiaHomeUrl @"http://api.haodou.com/mall/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&appsign=bfb3356caf9080ee2fbcd25da29df03e&channel=appstore&deviceid=0f607264fc6318a92b9e13c65db7cd3c%7C38383751-77FD-4A8D-B903-C148F577F00B%7C6811EBB3-D96C-4F1D-8F88-534083938E05&format=json&loguid=&method=idx.index&nonce=1453872945&sessionid=1453868567&signmethod=md5&timestamp=1453872945&uuid=03b31d55771c2b02a638bab33220668b&v=2&vc=45&vn=v6.0.1"

#define ADUrl @"http://api.haodou.com/mall/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&appsign=434838ba431ab8cd8996703f41a56148&channel=appstore&deviceid=0f607264fc6318a92b9e13c65db7cd3c%7C38383751-77FD-4A8D-B903-C148F577F00B%7C6811EBB3-D96C-4F1D-8F88-534083938E05&format=json&loguid=&method=collect.goodslist&nonce=1455197676&sessionid=1455179314&signmethod=md5&timestamp=1455197676&uuid=03b31d55771c2b02a638bab33220668b&v=2&vc=46&vn=v6.0.3"

#define GoodsDetailUrl @"http://api.haodou.com/mall/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&appsign=c153057673db33fafd4fa92e78a7a8c2&channel=appstore&deviceid=0f607264fc6318a92b9e13c65db7cd3c%7C38383751-77FD-4A8D-B903-C148F577F00B%7C6811EBB3-D96C-4F1D-8F88-534083938E05&format=json&loguid=&method=goods.view&nonce=1455535045&sessionid=1455525894&signmethod=md5&timestamp=1455535045&uuid=03b31d55771c2b02a638bab33220668b&v=2&vc=46&vn=v6.0.3"

#define kUrlString @"http://api.haodou.com/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&appsign=8d85e705bb108e20e1fc4aa5f5d70282&channel=appstore&deviceid=0f607264fc6318a92b9e13c65db7cd3c%7C816943C7-1FC6-4657-99E5-D42307123281%7CCE65FA99-36E9-42E7-B6D6-D9FE3F5F88B4&format=json&loguid=&nonce=1454986577&signmethod=md5&timestamp=1454986577&uuid=d10bc780b12ef17b9ac9f9dbcff00407&v=2&vc=46&vn=v6.0.3"

/**
 首页
 */
//method :
#define homeDataMethod @"index.index"          			//首页的数据
#define categoryDataMethod @"Search.getcatelist"			//分类的数据
#define hotDataMethod @"Search.getHotSearch"               //热门的搜素
#define recipeGetAlbumList @"Recipe.getAlbumList"
#define webViewInitWebView @"WebView.initWebView"
#define recipeGetCollectRecomment @"Recipe.getCollectRecomment"
#define readGetList @"Read.getList"
#define eventGetOfficialList @"Event.getOfficialList"
#define searchDataMethod @"Search.getList"                 //搜索的详细数据
//默认Limit=20&tagid=分类里的id
#define recipeDataMethod @"Info.getInfo"					//菜谱的详细数据

//rid=搜索的详细数据RecipeId
#define recipeVideoMethod @"Info.getVideoUrl"				//菜谱的做法和视频

//rid=搜索的详细数据RecipeId
#define commentDataMethod @"Comment.getList"               //菜谱的评论

//默认limit=10&rid=搜索的详细数据RecipeId
#define kitchenDataMethod @"Wiki.getListByType" 			//厨房宝典
//type=宝典列表的id&limit=10
#define bibleDataMethod @"Wiki.getTagList"      			//宝典列表
#define newsListMethod @"Topic.view"                       //新闻列表
//id=厨房宝典的itemid&默认limit=20
#define showDataMethod @"Show.discovery"                   //晒一晒列表
#define showDetailMethod @"Show.listing"					//晒一晒详细
//topicTag= 晒一晒列表的TopicId
#define showIndoMethod @"Show.info"                        //晒一晒详细
//showId=晒一晒列表的Pid
#define collectGoodMethod @"collect.goodslist"				//售卖详情
//Id=222&limit=20
#define recipeDetailMethod @"Info.getAlbumInfo"			//菜谱详情
//aid=8851781&limit=10

#define randColorNumber     arc4random() % 100 * 0.01

//topic
#define UrlString @"http://api.haodou.com/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&appsign=bd0a17884fe8ca31e47315eca4a3fc2a&channel=appstore&deviceid=0f607264fc6318a92b9e13c65db7cd3c%7CA439AA9B-C81E-4B3B-9D19-4462A666AE8B%7C8AA916CE-BFEA-48B6-9F43-03E5C3FBCDB0&format=json&loguid=&method=Topic.indexTopic&nonce=1456052211&sessionid=1456051986&signmethod=md5&timestamp=1456052211&uuid=2cec45a1059141da97cca18b9d451400&v=2&vc=46&vn=v6.0.3"

#define PeopleUrlString @"http://api.haodou.com/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&appsign=f17d810e6ecac9ab7147e3c54b7cb476&channel=appstore&deviceid=0f607264fc6318a92b9e13c65db7cd3c%7CA439AA9B-C81E-4B3B-9D19-4462A666AE8B%7C8AA916CE-BFEA-48B6-9F43-03E5C3FBCDB0&format=json&loguid=&method=Topic.indexPeople&nonce=1456107949&sessionid=1456107791&signmethod=md5&timestamp=1456107949&uuid=2cec45a1059141da97cca18b9d451400&v=2&vc=46&vn=v6.0.3"


#define DataMethod @"Topic.indexTopic"
#define PeopleDataMethod @"Topic.indexPeople"


#endif /* Common_h */
