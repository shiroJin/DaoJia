//
//  ListModel.m
//  项目三首页
//
//  Created by mac on 16/2/9.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

- (void)setAttributes:(NSDictionary *)jsonDic {

    [super setAttributes:jsonDic];
    
    _tags = [NSMutableArray array];
    
    self.title = [jsonDic objectForKey:@"Title"];
    self.subTitle = [jsonDic objectForKey:@"SubTitle"];
    self.intro = [jsonDic objectForKey:@"Intro"];
    self.img = [jsonDic objectForKey:@"Img"];
    self.image = [jsonDic objectForKey:@"Image"];
    self.url = [jsonDic objectForKey:@"Url"];
    self.cover = [jsonDic objectForKey:@"Cover"];
    self.cateId = [[jsonDic objectForKey:@"CateId"] integerValue];
    self.recipeId = [[jsonDic objectForKey:@"RecipeId"] integerValue];
    self.userId = [[jsonDic objectForKey:@"UserId"] integerValue];
    self.userName = [jsonDic objectForKey:@"UserName"];
    self.content = [jsonDic objectForKey:@"Content"];
    self.collection = [jsonDic objectForKey:@"Collection"];
    self.likeCount = [[jsonDic objectForKey:@"LikeCount"] integerValue];
    self.recipeID = [[jsonDic objectForKey:@"RecipeId"] integerValue];
    self.idNum = [[jsonDic objectForKey:@"Id"] integerValue];
    self.stuff = [jsonDic objectForKey:@"Stuff"];

    self.cateName = [jsonDic objectForKey:@"CateName"];
    self.hasVideo = [[jsonDic objectForKey:@"HasVideo"] boolValue];
    self.isLike = [[jsonDic objectForKey:@"IsLike"] boolValue];
    
    for (NSDictionary *dic in jsonDic[@"Tags"]) {
        
        TagModel *model = [[TagModel alloc] initContentWithDic:dic];
        
        [_tags addObject:model];
    }
    
}

//- (NSMutableArray *)tags {
//
//    if (!_tags) {
//        return [[NSMutableArray alloc] init];
//    }
//    
//    return _tags;
//    
//}
//Url	String	"haodourecipe://haodou.com/goods/subjectlist/?id=237"
//Url	String	"haodourecipe://haodou.com/collect/info/?id=6074270"
//Url	String	"haodourecipe://haodou.com/openurlid/?id=553363"
//Url	String	"haodourecipe://haodou.com/collect/info/?id=9406637"
//Url	String	"haodourecipe://haodou.com/opentopic/?url=http%3A%2F%2Fm.haodou.com%2Ftopic-422021.html&id=422021"
//Url	String	"haodourecipe://haodou.com/recipe/info/?id=480425&video=0"

- (void)setUrl:(NSString *)url {

    if (_url != url) {
        _url = url;
        
        NSArray *array = [_url componentsSeparatedByString:@"/"];
        
        NSMutableArray *arrData = [NSMutableArray arrayWithArray:array];
        
        [arrData removeObjectAtIndex:0];
        [arrData removeObjectAtIndex:0];
        [arrData removeObjectAtIndex:0];
        
        //NSLog(@"%@", arrData);
        
        NSString *firstStr = [arrData objectAtIndex:0];
        NSString *lastStr = [arrData lastObject];
        
        if ([firstStr isEqualToString:@"goods"]) {
            self.method = collectGoodMethod;
            
            NSString *idStr = [lastStr substringFromIndex:4];
            
            self.modelId = [idStr integerValue];
            
            //NSLog(@"%ld", self.modelId);
        } else if ([firstStr isEqualToString:@"collect"]) {
            self.method = recipeDetailMethod;
            
            NSString *idStr = [lastStr substringFromIndex:4];
            
            self.modelId = [idStr integerValue];
            
            //NSLog(@"%ld", self.modelId);
        } else if ([firstStr isEqualToString:@"openurlid"]) {
            self.method = @"WebView.initWebView";
            
            NSString *idStr = [lastStr substringFromIndex:4];
            
            self.modelId = [idStr integerValue];
            
            //NSLog(@"%ld", self.modelId);
        } else if ([firstStr isEqualToString:@"opentopic"]) {
            self.method = newsListMethod;
            
            NSString *urlStr = [lastStr substringFromIndex:5];
            NSArray *arr = [urlStr componentsSeparatedByString:@"&"];
            NSString *idStr = [arr lastObject];
            
            self.hasUrl = YES;
            //http%3A%2F%2Fm.haodou.com%2Ftopic-422021.html
            NSString *url = [arr firstObject];
            NSArray *arrayOfUrl = [url componentsSeparatedByString:@"%2F"];
            
            NSString *urlString = [NSString stringWithFormat:@"http://%@/%@", arrayOfUrl[2], arrayOfUrl[3]];
            
            
            self.urlString = urlString;
        
            self.modelId = [[idStr substringFromIndex:3] integerValue];
        } else if ([firstStr isEqualToString:@"recipe"]) {
        
            self.method = recipeDataMethod;
            
            NSArray *arr = [lastStr componentsSeparatedByString:@"&"];
            
            self.modelId = [[[arr firstObject] substringFromIndex:4] integerValue];
            
            self.hasVideo = [[[arr lastObject] substringFromIndex:6] boolValue];
            
        }
        
    }
    

}

@end
