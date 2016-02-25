//
//  DealDetailTable.m
//  BaiduAPIRequest
//
//  Created by Macx on 16/2/13.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "DealDetailTable.h"
#import "HeadCell.h"
#import "PriceCell.h"
#import "UIViewExt.h"
#import "WebViewCell.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation DealDetailTable

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"HeadCell" bundle:nil] forCellReuseIdentifier:@"head"];
        [self registerNib:[UINib nibWithNibName:@"PriceCell" bundle:nil] forCellReuseIdentifier:@"price"];
        [self registerNib:[UINib nibWithNibName:@"WebViewCell" bundle:nil] forCellReuseIdentifier:@"web"];
    }
    return self;
}

#pragma mark - 表视图代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return kScreenWidth * 15 / 32;
    }else if (indexPath.row == 1) {
        return 60;
    }else {
        return kScreenHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        HeadCell *head = [self dequeueReusableCellWithIdentifier:@"head"];
        head.imgUrl = _data[@"image"];
        head.title = _data[@"title"];
        head.sale_num = _data[@"sale_num"];
        head.longTitle = _data[@"long_title"];
        return head;
    }else if (indexPath.row == 1){
        PriceCell *price = [self dequeueReusableCellWithIdentifier:@"price"];
        price.currentPrice = _data[@"current_price"];
        price.marketPrice = _data[@"market_price"];
        return price;
    }else
    {
//        WebViewCell *web = [self dequeueReusableCellWithIdentifier:@"web"];
//        web.url = _data[@"deal_murl"];
        return nil;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    HeadCell *head = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UIImageView *imgView = head.image;
    UIView *bottomView = head.bottomView;
    CGFloat offsetY = self.contentOffset.y;
    
    if (offsetY < 0) { //向下滑动
        CGFloat height = ABS(offsetY) + head.height;
        CGFloat width = kScreenWidth / head.height * height;
        CGRect frame = CGRectMake(- (width - kScreenWidth) / 2, offsetY, width, height);
        
        imgView.frame = frame;
    }
    bottomView.bottom = imgView.bottom;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
