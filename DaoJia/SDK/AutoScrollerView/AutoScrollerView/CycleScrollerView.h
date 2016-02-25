//
//  CycleScrollerView.h
//  AutoScrollerView
//
//  Created by Macx on 16/2/8.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PageControlMode) {
    PageControlTop,
    PageControlBottom,
};

@interface CycleScrollerView : UIView <UIScrollViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame imgs:(NSArray *)imgArr isNetImage:(BOOL)isNet separation:(CGFloat)separationSize;

@property (nonatomic, assign) BOOL isAutoCycle;
@property (nonatomic, assign) CGFloat timeInterval;//默认为1.5s
@property (nonatomic, strong) UIColor *indictorColor;
@property (nonatomic, strong) UIColor *currentIndictorColor;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) PageControlMode pageControlMode;
@property (nonatomic, copy) void(^tapImgBlock)(NSInteger currentIndex);

@end
