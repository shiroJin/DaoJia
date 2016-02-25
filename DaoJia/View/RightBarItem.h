//
//  RightBarItem.h
//  DaoJia
//
//  Created by Macx on 16/2/10.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectBlock) (NSInteger selectIndex);

@interface RightBarItem : UIButton

- (void)setTitleArray:(NSArray *)titleArr selectBlock:(SelectBlock)selectBlock;

@end
