//
//  RequestManager.h
//  DaoJia
//
//  Created by Macx on 16/2/10.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestManager : NSObject

+ (void)requestWithURL:(NSString  *)url params:(NSMutableDictionary *)params success:(void (^)(id result))SuccessBlock;

+ (void)requestNuomiWithURL:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id))SuccessBlock;

@end
