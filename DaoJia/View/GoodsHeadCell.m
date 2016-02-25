//
//  GoodsHeadCell.m
//  DaoJia
//
//  Created by Macx on 16/2/15.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "GoodsHeadCell.h"
#import "CycleScrollerView.h"
#import "ScreenScroller.h"

@implementation GoodsHeadCell
{
    CycleScrollerView *_scroller;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setImgArr:(NSArray *)imgArr {
    if (_imgArr != imgArr) {
        _imgArr = imgArr;
        
        _scroller = [[CycleScrollerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) imgs:_imgArr isNetImage:YES separation:0];
        _scroller.timeInterval = 6.0f;
        _scroller.pageControlMode = PageControlBottom;
        [_scroller setTapImgBlock:^(NSInteger index) {
            ScreenScroller *scroller = [[ScreenScroller alloc] initWithImgs:imgArr currentIndex:index];
            [[UIApplication sharedApplication].keyWindow addSubview:scroller];
        }];
        [self addSubview:_scroller];
    }
}

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
