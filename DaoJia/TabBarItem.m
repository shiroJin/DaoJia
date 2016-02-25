//
//  TabBarItem.m
//  标签栏
//
//  Created by Macx on 16/2/12.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "TabBarItem.h"
#define kItemWidth self.bounds.size.width
#define kItemHeight self.bounds.size.height
#define kImgSize 30
#define kLabelHeight 12

@implementation TabBarItem

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //图片
    UIImage *img = nil;
    if (!self.selected) {
        img = [UIImage imageNamed:_imgName];
    }else {
        img = [UIImage imageNamed:_selectedImgName];
    }
    [img drawInRect:CGRectMake((kItemWidth - kImgSize) / 2, 5, kImgSize, kImgSize)];
    //title
    NSString *title = self.title;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = NSTextAlignmentCenter;
    UIColor *color = nil;
    if (!self.selected) {
        color = [UIColor darkGrayColor];
    }else {
        color = [UIColor colorWithRed:103/255 green:151/255 blue:0 alpha:1];
    }
    [title drawInRect:CGRectMake(0, kItemHeight - kLabelHeight, kItemWidth, kLabelHeight) withAttributes:@{
                                                                                                           NSFontAttributeName : [UIFont systemFontOfSize:8],
                                                                                                          NSForegroundColorAttributeName : color,
                                                                                                          NSParagraphStyleAttributeName : paraStyle,
                                                                                                          }];
}


#pragma mark - 点击事件
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.selected = !self.selected;
//}

@end
