//
//  HeadSectionView.m
//  好豆菜谱ZN
//
//  Created by Macx on 16/2/21.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "HeadSectionView.h"

@implementation HeadSectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        _leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        
        _rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-20, 0, 20, 20)];
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 100, 20)];
        
        [self addSubview:_leftImage];
        [self addSubview:_rightImage];
        [self addSubview:_titleLable];

        
    }
    return self;
}

@end
