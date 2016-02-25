//
//  DailyModel.h
//  DaoJia
//
//  Created by Macx on 16/2/11.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "BaseModel.h"

@interface DailyModel : BaseModel

@property (nonatomic, copy)NSString *Label;
@property (nonatomic, copy)NSString *Title;
@property (nonatomic, copy)NSString *CoverUrl;
@property (nonatomic, copy)NSString *Price;
@property (nonatomic, copy)NSString *IsAuto;
@property (nonatomic, copy)NSString *OpenUrl;

@end
