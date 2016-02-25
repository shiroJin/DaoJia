//
//  GoodsDetailTable.m
//  DaoJia
//
//  Created by Macx on 16/2/15.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "GoodsDetailTable.h"
#import "GoodsHeadCell.h"
#import "GoodsInfoCell.h"
#import "SurveyCell.h"
#import "ContentCell.h"
#import "UIView+ViewController.h"
#import "GoodsDetailController.h"

@implementation GoodsDetailTable
{
    NSArray *_imgUrls;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[GoodsHeadCell class] forCellReuseIdentifier:@"head"];
        [self registerNib:[UINib nibWithNibName:@"GoodsInfoCell" bundle:nil] forCellReuseIdentifier:@"info"];
        [self registerNib:[UINib nibWithNibName:@"SurveyCell" bundle:nil] forCellReuseIdentifier:@"survey"];
        [self registerNib:[UINib nibWithNibName:@"ContentCell" bundle:nil] forCellReuseIdentifier:@"img"];
        
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return self;
}

- (NSArray *)imgUrls {
    if (!_imgUrls) {
        _imgUrls = self.goods.Content;
    }
    return _imgUrls;
}

#pragma mark - 表视图代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = self.contentOffset.y;
    if (offsetY > 10) {
        ((GoodsDetailController *)self.ViewController).navigationBar.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:offsetY / 156];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3 + [self imgUrls].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200;
    }
    else if (indexPath.row < 3) {
        return 80;
    }
    else {
        return 200;//内容图片高度
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        GoodsHeadCell *head = [self dequeueReusableCellWithIdentifier:@"head"];
        head.imgArr = self.goods.ImgInfo;
        return head;
    }
    else if (indexPath.row == 1) {
        GoodsInfoCell *info = [self dequeueReusableCellWithIdentifier:@"info"];
        info.goods = self.goods;
        return info;
    }else if (indexPath.row == 2){
        SurveyCell *survey = [self dequeueReusableCellWithIdentifier:@"survey"];
        survey.goods = self.goods;
        return survey;
    }else {
        ContentCell *img = [self dequeueReusableCellWithIdentifier:@"img"];
        img.imgUrl = _imgUrls[indexPath.row - 3][@"ImgUrl"];
        return img;
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
