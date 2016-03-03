//
//  ScrollerCell.m
//  DaoJia
//
//  Created by Macx on 16/2/10.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "ScrollerCell.h"
#import "CycleScrollerView.h"
#import "AdModel.h"
#import "UIView+ViewController.h"
#import "ADDetailViewController.h"

@interface ScrollerCell ()

@property (nonatomic, copy)NSMutableArray *idArray;

@end

@implementation ScrollerCell
{
    CycleScrollerView *_scroller;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

//传入数据
- (void)setAdArr:(NSArray *)adArr {
    if (_adArr != adArr) {
        _adArr = adArr;
        
        NSMutableArray *urlArray = [NSMutableArray array];
        NSMutableArray *imgArr = [NSMutableArray array];
        for (AdModel *ad in _adArr) {
            NSString *imgUrl = ad.ImgUrl;
            [imgArr addObject:imgUrl];
            
            NSString *url = ad.Url;
            [urlArray addObject:url];
        }
        
        [self parseUrl:urlArray];
        
        //创建滑动视图
        if (!_scroller) {
            _scroller = [[CycleScrollerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.bounds.size.height) imgs:imgArr isNetImage:YES separation:5];
            [self.contentView addSubview:_scroller];
        }
        _scroller.timeInterval = 6.0f;
        _scroller.pageControlMode = PageControlBottom;
        _scroller.currentIndictorColor = [UIColor orangeColor];
        
        [self setBlock];
    }
}

- (void)parseUrl:(NSArray *)array {
    if (!_idArray) {
        _idArray = [NSMutableArray array];
    }
    for (NSString *url in array) {
        NSUInteger start = [url rangeOfString:@"="].location;
        NSUInteger length = url.length;
        NSString *adID = [url substringWithRange:NSMakeRange(start + 1, length - start - 1)];
        [_idArray addObject:adID];
    }
}

//点击事件
- (void)setBlock {
    __weak typeof(self) wself = self;
    [_scroller setTapImgBlock:^(NSInteger currentIndex) {
        ADDetailViewController *view = [[ADDetailViewController alloc] init];
        view.adID = wself.idArray[currentIndex];
        [wself.navigationController pushViewController:view animated:YES];
    }];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
