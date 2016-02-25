//
//  TitleButton.m
//  DaoJia
//
//  Created by Macx on 16/2/15.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 1);
    
    CGPoint point = CGPointMake(0, CGRectGetMaxY(self.frame));
    CGPoint point2 = CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame));
    CGPoint points[] = {point, point2};
    
    CGContextAddLines(context, points, 2);
    
    
    NSString *str = self.title;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = NSTextAlignmentCenter;
    UIColor *color = [UIColor blackColor];
    if (self.selected == YES) {
        color = [UIColor orangeColor];
    }
    
    [str drawInRect:self.bounds withAttributes:@{
                                                NSParagraphStyleAttributeName : paraStyle,
                                                NSForegroundColorAttributeName : color,
                                                }];
}


@end
