//
//  discountPrice.m
//  dfa
//
//  Created by Macx on 16/2/15.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "discountPrice.h"

#define kWidth self.bounds.size.width
#define kHeight self.bounds.size.height

@implementation discountPrice


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSInteger count = 0;
    NSString *str = nil;
    
    if (self.price) {
        NSInteger price = [self.price integerValue] / 100;
        count = log10((double)price) + 1 + 2;
        str = [NSString stringWithFormat:@"原价:%.2f", [self.price floatValue] / 100];
    }
    
    if (self.strPrice) {
        count = self.strPrice.length;
        str = [NSString stringWithFormat:@"原价:%@", self.strPrice];
    }
    
    if (str.length > 0) {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.alignment = NSTextAlignmentLeft;
        [str drawInRect:CGRectMake(0, 0, 30 + 7 * count, kHeight) withAttributes:@{
                                                                                  NSForegroundColorAttributeName : [UIColor blackColor]
                                                                                  }];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, kHeight / 4);
        CGPathAddLineToPoint(path, NULL, 30 + 7 * count, kHeight / 4 * 3);
        CGContextAddPath(context, path);
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
        CGContextDrawPath(context, kCGPathFillStroke);
        CGPathRelease(path);
        context = nil;
    }
}


@end
