//
//  RightBarItem.m
//  DaoJia
//
//  Created by Macx on 16/2/10.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "RightBarItem.h"
#import "TitleButton.h"

#define kStatusBarHeight 20
#define kWidth self.bounds.size.width
#define kHeight self.bounds.size.height
#define kArrowIcon @"common_icon_arrow"

@implementation RightBarItem
{
    NSArray *status;//范围名
    UIView *listView;//范围选项
    NSInteger _selectIndex;
    NSArray *_titleArr;
    SelectBlock _selectBlock;
}
/*
 
 */

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
#pragma mark - 绘制标签
- (void)drawRect:(CGRect)rect {
    
    NSString *str = @"糯米";
    
    UIFont *font = [UIFont systemFontOfSize:16];
    UIColor *color = [UIColor orangeColor];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{
                                 NSFontAttributeName : font,
                                 NSParagraphStyleAttributeName : style,
                                 NSForegroundColorAttributeName : color
                                 };
    [str drawInRect:CGRectMake(0, 10, 40, 30) withAttributes:attributes];
    
    UIImage *arrow = [UIImage imageNamed:kArrowIcon];
    CGContextRef context =  UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    if (self.selected) {
        CGContextRotateCTM(context, M_PI_2);
        [arrow drawInRect:CGRectMake(10, -60, 20, 20)];
    } else {
        CGContextRotateCTM(context, -M_PI_2);
        [arrow drawInRect:CGRectMake(-30, 40, 20, 20)];
    }
    CGContextRestoreGState(context);
}

#pragma mark - 触摸事件
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.selected = !self.selected;
    if (self.selected) {
        if (!listView) {
            [self listView];
        }
        listView.alpha = 1;
    }else {
        listView.alpha = 0;
    }
}

- (UIView *)listView {
    if (!listView) {
        listView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame), self.bounds.size.width, 30 * 4)];
        listView.backgroundColor = [UIColor whiteColor];
        for (int i = 0; i < 4; i++) {
            TitleButton *button = [[TitleButton alloc] initWithFrame:CGRectMake(0, 30 * i, self.bounds.size.width, 30)];
            button.title = _titleArr[i];
            button.backgroundColor = [UIColor whiteColor];
            button.tag = 100 + i;
            [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [listView addSubview:button];
        }
        [[self window] addSubview:listView];
        listView.alpha = 0;
    }
    
    return listView;
}

- (void)click:(UIControl *)sender {
    static NSInteger preIndex = -1;
    if (preIndex == sender.tag) {
        NSInteger selectIndex = preIndex - 100;
        _selectBlock(selectIndex);
        listView.alpha = 0;
        self.selected = NO;
        return;
    }
    UIControl *control = [listView viewWithTag:preIndex];
    if (control) {
        control.selected = NO;
    }
    
    preIndex = sender.tag;
    sender.selected = !sender.selected;
    NSInteger selectIndex = sender.tag - 100;
    _selectIndex = selectIndex;
    listView.alpha = 0;
    self.selected = NO;
    _selectBlock(selectIndex);
}

- (void)setTitleArray:(NSArray *)titleArr selectBlock:(SelectBlock)selectBlock {
    _titleArr = titleArr;
    _selectBlock = selectBlock;
}


- (UIWindow *)window {
    return [UIApplication sharedApplication].keyWindow;
}

@end
