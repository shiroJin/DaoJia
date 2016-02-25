//
//  RequestManager.m
//  DaoJia
//
//  Created by Macx on 16/2/10.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "RequestManager.h"
#import "AFNetworking.h"

/*
http://api.haodou.com/mall/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&appsign=bfb3356caf9080ee2fbcd25da29df03e&channel=appstore&deviceid=0f607264fc6318a92b9e13c65db7cd3c%7C38383751-77FD-4A8D-B903-C148F577F00B%7C6811EBB3-D96C-4F1D-8F88-534083938E05&format=json&loguid=&method=idx.index&nonce=1453872945&sessionid=1453868567&signmethod=md5&timestamp=1453872945&uuid=03b31d55771c2b02a638bab33220668b&v=2&vc=45&vn=v6.0.1
 */

@implementation RequestManager

#pragma mark - 数据好豆接口
+ (void)requestWithURL:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id))SuccessBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        SuccessBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"haodou request failed");
    }];
    
}

#pragma mark - 百度API 网络请求接口
+ (void)requestNuomiWithURL:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id))SuccessBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [manager.requestSerializer setValue:@"f4386168b45e296010c025ebe3cb0ced" forHTTPHeaderField:@"apikey"];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        SuccessBlock(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"nuomi request failed");
    }];
}

@end
