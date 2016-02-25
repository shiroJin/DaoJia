//
//  CatHeadView.m
//  DaoJia
//
//  Created by Macx on 16/2/14.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "CatHeadView.h"
#define kHeight self.bounds.size.height

@implementation CatHeadView
{
    UILabel *_label;
    UIImageView *_icon;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kHeight, kHeight)];
    [self addSubview:_icon];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(kHeight + 5, 0, 100, kHeight)];
    _label.textColor = [UIColor orangeColor];
    _label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_label];
}

- (void)setTitle:(NSString *)title {
    if (![_title isEqualToString:title]) {
        _title = title;
        _label.text = _title;
    }
}

- (void)setIconImgName:(NSString *)iconImgName {
    if (![_iconImgName isEqualToString:iconImgName]) {
        _iconImgName = iconImgName;
        _icon.image = [UIImage imageNamed:_iconImgName];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
