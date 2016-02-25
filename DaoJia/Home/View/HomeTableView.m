//
//  HomeTableView.m
//  项目三首页
//
//  Created by mac on 16/2/9.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "HomeTableView.h"
#import "ListModel.h"
#import "HomeCycleScrollView.h"
#import "UIButton+WebCache.h"
#import "NewsTableView.h"
#import "AlbumInfoViewController.h"
#import "BasicNaviController.h"
#import "HaoDouControl.h"
#import "TopicViewController.h"
#import "KitctnViewController.h"
#import "LikeViewController.h"
#import "ReadViewController.h"
#import "HomeSearchViewController.h"

@interface HomeTableView () <UITextFieldDelegate>
{
    UITextField *_textField;
    NSArray *_heightArray;
}

@end

@implementation HomeTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];

    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        _dataDic = [[NSMutableDictionary alloc] init];
        _heightArray = @[@"220", @"75", @"160", @"180", @"100", @"160", @"280", @"280", @"180"];
        
        self.backgroundColor = [UIColor clearColor];
        self.tableHeaderView.userInteractionEnabled = YES;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

- (void)showFunctions:(UIButton *)button {


}

- (UITableViewCell *)firstCell {

    CGFloat height = [_heightArray[0] floatValue];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *modelArr = [NSMutableArray array];
    
    NSArray *jsonData = [[_dataDic objectForKey:@"recipe"] objectForKey:@"list"];
    if (jsonData) {
        
        for (int i = 0; i < jsonData.count; i++) {
            NSDictionary *dic = jsonData[i];
            
            ListModel *model = [[ListModel alloc] initContentWithDic:dic];
            
            [modelArr addObject:model];
            
            NSString *str = model.img;
            NSURL *url = [NSURL URLWithString:str];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, height)];
            [imageView sd_setImageWithURL:url];
            
            CGRect rect = [model.title boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                            
                                                                                                                                            NSFontAttributeName : [UIFont systemFontOfSize:12]
                                                                                                                                            
                                                                                                                                            } context:nil];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - rect.size.width / 2 - 10, height - 40, rect.size.width + 20, 20)];
            label.text = model.title;
            label.backgroundColor = [UIColor redColor];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = 10;
            [imageView addSubview:label];
            
            [array addObject:imageView];
        }
        
    }
    
    HomeCycleScrollView *scrollView = [[HomeCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height) animationDuration:3];
    
    __weak typeof(self) weakSelf = self;
    scrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return array[pageIndex];
    };

    scrollView.totalPagesCount = ^NSInteger(void){
        return array.count;
    };
    
    scrollView.TapActionBlock = ^(NSInteger pageIndex){
        
        ListModel *model = [modelArr objectAtIndex:pageIndex];
        
        if ([model.method isEqualToString:recipeDetailMethod]) {
            
            AlbumInfoViewController *view = [[AlbumInfoViewController alloc] init];
            
            view.ablumID = model.modelId;
            
            BasicNaviController *navi = [[BasicNaviController alloc] initWithRootViewController:view];
            
            [weakSelf.ViewController presentViewController:navi animated:YES completion:^{
                
            }];
            
        } else if ([model.method isEqualToString:newsListMethod]) {
            
            TopicViewController *view = [[TopicViewController alloc] init];
            
            view.urlString = model.urlString;
            
            BasicNaviController *navi = [[BasicNaviController alloc] initWithRootViewController:view];
            
            [weakSelf.ViewController presentViewController:navi animated:YES completion:^{
                
            }];
        
        }
        
    };
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 60 , CGRectGetMaxY(scrollView.frame) - 20, 120, 20)];
    
    pageControl.numberOfPages = array.count;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    __weak typeof(pageControl) weakPageControl = pageControl;
    scrollView.changeCurrentPage = ^(NSInteger pageIndex) {
        
        weakPageControl.currentPage = pageIndex;
        
    };
    
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    scrollView.tag = 600;
    
    [cell addSubview:scrollView];
    [cell addSubview:pageControl];
    
    return cell;
}

- (void)changePage:(UIPageControl *)pageControl {

    HomeCycleScrollView *scrollView = [pageControl.superview viewWithTag:600];
    
    scrollView.currentPage = pageControl.currentPage;
}

- (UITableViewCell *)secondCell {
    
    CGFloat height = [_heightArray[1] floatValue];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.backgroundColor =[UIColor blackColor];
    
    NSArray *jsonData = [[_dataDic objectForKey:@"tools"] objectForKey:@"list"];
    
    CGFloat width = kScreenWidth / 5;
    for (int i = 0; i < jsonData.count; i++) {
        NSDictionary *dic = jsonData[i];
        
        ListModel *model = [[ListModel alloc] initContentWithDic:dic];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(width * i, 0, width , height)];
        
        button.tag = 400 + i;
    
        [button addTarget:self action:@selector(showDetailCtrl:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width / 2 - width / 2.5 / 2, 10, width / 2.5, width / 2.5)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
        [button addSubview:imageView];
        
        CGRect rect = [model.title boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                        
                                                                                                                                        NSFontAttributeName : [UIFont systemFontOfSize:12]
                                                                                                                                        
                                                                                                                                        } context:nil];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((width - rect.size.width) / 2, CGRectGetMaxY(imageView.frame) + 5, rect.size.width, 20)];
        
        label.text = model.title;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:12];
        
        [button addSubview:label];
        
        [cell addSubview:button];
    }
    
    [self createGrayLabelWithCell:cell withHeight:height];
    
    return cell;
}

- (void)showDetailCtrl:(UIButton *)sender {

    NSInteger tag = sender.tag - 400;
    
    switch (tag) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            {
                KitctnViewController *viewCtrl = [[KitctnViewController alloc] init];
                
                viewCtrl.method = kitchenDataMethod;
                viewCtrl.title = @"厨房宝典";
                
                BasicNaviController *navi = [[BasicNaviController alloc] initWithRootViewController:viewCtrl];
                
                [self.ViewController presentViewController:navi animated:YES completion:^{
                    
                }];
             }
            break;
        case 4:
            
            break;
            
        default:
            break;
    }

}

- (UITableViewCell *)thirdCell {
    
    CGFloat height = [_heightArray[2] floatValue];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *jsonData = [_dataDic objectForKey:@"album"];

    [self createSmallTitleWithDic:jsonData withCell:cell];
    
    NSArray *arr = jsonData[@"list"];
    
    CGFloat width = kScreenWidth / 2 - 15;
    for (int i = 0; i < 2; i++) {
        NSDictionary *dic = [arr objectAtIndex:i];
        
        CGRect frame = CGRectMake(10 + (10 + width) * i , 40, width, height - 40 - 15);
        [self createSmallContextWith:dic withFrame:frame withCell:cell];
    }
    
    [self createGrayLabelWithCell:cell withHeight:height];
    
    return cell;
}

- (UITableViewCell *)forthCell {
    
    CGFloat height = [_heightArray[3] floatValue];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSDictionary *jsonData = [_dataDic objectForKey:@"person"];

    [self createSmallTitleWithDic:jsonData withCell:cell];

    NSArray *dataArr = jsonData[@"tag"];
    
    CGFloat width = kScreenWidth - 20;
    CGFloat heightOfMain = height - 40 - 15;
    CGFloat buttonWidth = width / dataArr.count;
    
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, heightOfMain - 20, width, 20)];
    selectView.backgroundColor = [UIColor blackColor];
    selectView.alpha = 0.5;
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < dataArr.count; i++) {
        
        NSDictionary *dic = [dataArr objectAtIndex:i];
        
        ListModel *model = [[ListModel alloc] initContentWithDic:dic];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width * i, 0, width, heightOfMain)];
        
        //add by jin
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
 
        //[scrollView addSubview:imageView];
        [array addObject:imageView];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth * i, 0, buttonWidth, selectView.height)];
        
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        
        [button setTitle:model.cateName forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        button.tag = 100 + i;
        button.backgroundColor = [UIColor clearColor];
        
        if (i == 0) {
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        button.layer.cornerRadius = 8;
        
        [selectView addSubview:button];
    }
   
    HomeCycleScrollView *scrollView = [[HomeCycleScrollView alloc] initWithFrame:CGRectMake(10, 40, kScreenWidth - 20, heightOfMain) animationDuration:0];
    
    scrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return array[pageIndex];
    };
    
    scrollView.totalPagesCount = ^NSInteger(void){
        return array.count;
    };
    
    scrollView.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"点击了第%ld个", pageIndex);
        
        ListModel *model = [[ListModel alloc] initContentWithDic:dataArr[pageIndex]];
        
        KitctnViewController *view = [[KitctnViewController alloc] init];
        
        view.title = model.cateName;
        view.tagid = model.cateId;
        view.method = searchDataMethod;
        
        BasicNaviController *navi = [[BasicNaviController alloc] initWithRootViewController:view];
        
        [self.ViewController presentViewController:navi animated:YES completion:^{
            
        }];
        
    };
    
    __weak typeof(selectView) weakSelectView = selectView;
    scrollView.changeCurrentPage = ^(NSInteger pageIndex){
        
        for (UIButton *button in weakSelectView.subviews) {
            button.backgroundColor = [UIColor clearColor];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            
        }
        
        UIButton *button = [weakSelectView viewWithTag:100 + pageIndex];
        
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    };
    
    [scrollView addSubview:selectView];

//    for (UIButton *button in selectView.subviews) {
//        [button addTarget:scrollView action:@selector(animationWithSelectIndexWithButton:) forControlEvents:UIControlEventTouchUpInside];
//    }

    [cell addSubview:scrollView];
    
    [self createGrayLabelWithCell:cell withHeight:height];
    
    return cell;
}

- (UITableViewCell *)fifthCell {
    
    CGFloat height = [_heightArray[4] floatValue];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *jsonData = [_dataDic objectForKey:@"goods"];

    NSArray *dataArr = [jsonData objectForKey:@"list"];
    
    CGFloat width = kScreenWidth / 4;
    for (int i = 0; i < dataArr.count; i++) {
        NSDictionary *dic = [dataArr objectAtIndex:i];
        
        ListModel *model = [[ListModel alloc] initContentWithDic:dic];
        
        UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(width * i, 5, width - 20, height - 10)];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, control.width - 10, 20)];
        
        titleLabel.text = model.title;
        titleLabel.font = [UIFont systemFontOfSize:10];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [control addSubview:titleLabel];
        
        UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(control.width / 2 - 10, 20, 30, 12)];
        
        subTitleLabel.text = model.subTitle;
        subTitleLabel.textColor = [UIColor orangeColor];
        subTitleLabel.textAlignment = NSTextAlignmentCenter;
        subTitleLabel.font = [UIFont systemFontOfSize:8];
        
        [control addSubview:subTitleLabel];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, control.width, control.height - 32)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
        
        [control addSubview:imageView];
        [cell addSubview:control];
    }
    
    [self createGrayLabelWithCell:cell withHeight:height];
    
    return cell;
}

- (UITableViewCell *)sixthCell {
    
    CGFloat height = [_heightArray[5] floatValue];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *jsonData = [_dataDic objectForKey:@"recommed"];
    
    CGFloat width = (kScreenWidth - 30) / 2;
    CGFloat imageHeight = height - 20;
    
    NSArray *dataArr = jsonData[@"list"];
    
    CGFloat imgheight = (imageHeight - 5) / 2;
    for (int i = 0; i < 2; i++) {
        UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(10, 10 + imgheight * i, width, imgheight)];
        
        control.tag = i;
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5 * i, width, imgheight)];
        
        ListModel *model = [[ListModel alloc] initContentWithDic:[dataArr objectAtIndex:i]];
        
        if (model.modelId) {
            control.tag = model.modelId;
        }
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:model.img]];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, imgView.height)];
        
        label.text = model.title;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor colorWithRed:108 / 255.0 green:197 / 255.0 blue:105 / 255.0 alpha:1];
        label.textColor = [UIColor whiteColor];
        
        [imgView addSubview:label];
    
        [control addSubview:imgView];
        [cell addSubview:control];
        
        [control addTarget:self action:@selector(clickControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    NSDictionary *adDic = jsonData[@"ad"];
    
    ListModel *adModel = [[ListModel alloc] initContentWithDic:adDic];
    
    UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(width + 20, 10, width, imageHeight)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, imageHeight)];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:adModel.img]];
    
    [control addSubview:imageView];
    [cell addSubview:control];
    
    [self createGrayLabelWithCell:cell withHeight:height];
    
    return cell;
}

- (void)clickControlAction:(UIControl *)control {
    
    if (control.tag != 0) {
        TopicViewController *viewCtrl = [[TopicViewController alloc] init];
        
        viewCtrl.method = webViewInitWebView;
        viewCtrl.idnum = control.tag;
        
        BasicNaviController *navi = [[BasicNaviController alloc] initWithRootViewController:viewCtrl];
        
        [self.ViewController presentViewController:navi animated:YES completion:^{
            
        }];

    }
    
}

- (UITableViewCell *)seventhCell {
    
    CGFloat height = [_heightArray[6] floatValue];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *jsonData = [_dataDic objectForKey:@"read"];

    [self createSmallTitleWithDic:jsonData withCell:cell];
    
    NewsTableView *tableView = [[NewsTableView alloc] initWithFrame:CGRectMake(10, 40, kScreenWidth - 20, height - 40) style:UITableViewStylePlain];
    
    tableView.dataArray = jsonData[@"list"];
    
    tableView.backgroundColor = [UIColor clearColor];
    
    [cell addSubview:tableView];
    
    [self createGrayLabelWithCell:cell withHeight:height];
    
    return cell;
}

- (UITableViewCell *)eighthCell {

    CGFloat height = [_heightArray[7] floatValue];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *jsonData = [_dataDic objectForKey:@"event"];
    
    [self createSmallTitleWithDic:jsonData withCell:cell];
    
    NewsTableView *tableView = [[NewsTableView alloc] initWithFrame:CGRectMake(10, 40, kScreenWidth - 20, height - 40) style:UITableViewStylePlain];
    
    tableView.dataArray = jsonData[@"list"];
    
    tableView.backgroundColor = [UIColor clearColor];
    
    [cell addSubview:tableView];
    
    [self createGrayLabelWithCell:cell withHeight:height];
    
    return cell;
    
}

- (UITableViewCell *)ninethCell {

    CGFloat height = [_heightArray[7] floatValue];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *jsonData = [_dataDic objectForKey:@"vip"];
    
    [self createSmallTitleWithDic:jsonData withCell:cell];
    
    NSArray *array = jsonData[@"list"];
    
    CGFloat width = kScreenWidth / 5;
    for (int i = 0 ; i < array.count; i++) {
        
        NSDictionary *dic = array[i];
        
        ListModel *model = [[ListModel alloc] initContentWithDic:dic];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(width * i, 40, width, height - 40 - 60)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(button.width / 2 - 15, 0, 30, 30)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
        
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = imageView.width / 2;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 5, button.width, 20)];
        
        titleLabel.text = model.title;
        titleLabel.font = [UIFont systemFontOfSize:10];
        //titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [button addSubview:imageView];
        [button addSubview:titleLabel];
        [cell addSubview:button];
    }
    
    return cell;
}

- (void)createSmallContextWith:(NSDictionary *)dic withFrame:(CGRect )frame withCell:(UITableViewCell *)cell {

    HaoDouControl *control = [[HaoDouControl alloc] initWithFrame:frame];
    
    ListModel *model = [[ListModel alloc] initContentWithDic:dic];
    
    control.model = model;
    
    [control addTarget:self action:@selector(recipeViewShow:) forControlEvents:UIControlEventTouchUpInside];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, control.width - 40, control.height - 20)];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"Img"]]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.width / 2 - 20, imageView.height - 20 - 5, 40, 20)];
    label.text = dic[@"Recipe"];
    label.font = [UIFont systemFontOfSize:10];
    label.backgroundColor = [UIColor colorWithRed:108 / 255.0 green:197 / 255.0 blue:105 / 255.0 alpha:1];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 8;
    
    [imageView addSubview:label];
    [control addSubview:imageView];
    
    NSArray *arrData = dic[@"List"];
    
    CGFloat height = imageView.height / 3;
    for (int i = 0; i < 3; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 1, height * i + i - 1, 39, height)];
        
        NSDictionary *jsonDic = [arrData objectAtIndex:i];
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:jsonDic[@"Cover"]]];
        
        [control addSubview:imgView];
    }
    
    CGRect rect = [dic[@"Title"] boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                    
                                                                                                                                    NSFontAttributeName : [UIFont systemFontOfSize:11]
                                                                                                                                    
                                                                                                                                    } context:nil];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.width / 2 - rect.size.width / 2, CGRectGetMaxY(imageView.frame) + 3, rect.size.width, 17)];
    contentLabel.text = dic[@"Title"];
    contentLabel.font = [UIFont systemFontOfSize:11];
    
    [control addSubview:contentLabel];

    NSLog(@"%@", dic[@"Url"]);
    
    [cell addSubview:control];
}

- (void)createSmallTitleWithDic:(NSDictionary *)jsonData withCell:(UITableViewCell *)cell {

    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 20, 20)];
    
    [icon sd_setImageWithURL:[NSURL URLWithString:jsonData[@"icon"]]];
    
    //icon.backgroundColor = [UIColor blackColor];
    [cell addSubview:icon];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 70, 20)];
    nameLabel.text = jsonData[@"name"];
    nameLabel.font = [UIFont systemFontOfSize:14];
    
    [cell addSubview:nameLabel];
    
    UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 20 - 5, 10, 18, 18)];
    
    [moreButton setImage:[UIImage imageNamed:@"btn_more_arrowright"] forState:UIControlStateNormal];
    
    if ([jsonData[@"name"] isEqualToString:@"热门专辑"]) {
        moreButton.tag = 500 + 2;
    } else if ([jsonData[@"name"] isEqualToString:@"猜你喜欢"]) {
        moreButton.tag = 500 + 3;
    } else if ([jsonData[@"name"] isEqualToString:@"精品阅读"]) {
        moreButton.tag = 500 + 4;
    } else if ([jsonData[@"name"] isEqualToString:@"热门活动"]) {
        moreButton.tag = 500 + 5;
    }
    
    
    [moreButton addTarget:self action:@selector(showMore:) forControlEvents:UIControlEventTouchUpInside];
    
    moreButton.layer.cornerRadius = moreButton.width / 2;
    moreButton.layer.borderColor = [UIColor grayColor].CGColor;
    moreButton.layer.borderWidth = 1.0;
    
    [cell addSubview:moreButton];
}

- (void)showMore:(UIButton *)sender {

    NSLog(@"%ld", sender.tag);
    
    switch (sender.tag - 500) {
        case 2:
        {
            KitctnViewController *viewCtrl = [[KitctnViewController alloc] init];
            
            viewCtrl.method = recipeGetAlbumList;
            viewCtrl.title = @"专辑";
            
            BasicNaviController *navi = [[BasicNaviController alloc] initWithRootViewController:viewCtrl];
            
            [self.ViewController presentViewController:navi animated:YES completion:^{
                
            }];
        }
            break;
        case 3:
        {
            LikeViewController *viewCtrl = [[LikeViewController alloc] init];
            
            viewCtrl.title = @"猜你喜欢";
            
            BasicNaviController *navi = [[BasicNaviController alloc] initWithRootViewController:viewCtrl];
            
            [self.ViewController presentViewController:navi animated:YES completion:^{
                
            }];
        
        
        }
            break;
            
        case 4:
        {
            ReadViewController *viewCtrl = [[ReadViewController alloc] init];
            
            viewCtrl.title = @"精品阅读";
            viewCtrl.method = readGetList;
            
            BasicNaviController *navi = [[BasicNaviController alloc] initWithRootViewController:viewCtrl];
            
            [self.ViewController presentViewController:navi animated:YES completion:^{
                
            }];
            
        }
            break;
            
        case 5:
        {
            ReadViewController *viewCtrl = [[ReadViewController alloc] init];
            
            viewCtrl.title = @"热门活动";
            viewCtrl.method = eventGetOfficialList;
            
            BasicNaviController *navi = [[BasicNaviController alloc] initWithRootViewController:viewCtrl];
            
            [self.ViewController presentViewController:navi animated:YES completion:^{
                
            }];
            
            
        }
            break;

        default:
            break;
    }

}

- (void)createGrayLabelWithCell:(UITableViewCell *)cell withHeight:(CGFloat)height{

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, height - 5, kScreenWidth, 5)];
    label.backgroundColor = [UIColor grayColor];
    label.alpha = 0.3;
    
    [cell addSubview:label];

}

- (void)recipeViewShow:(HaoDouControl *)control {

    AlbumInfoViewController *view = [[AlbumInfoViewController alloc] init];
    
    view.ablumID = control.model.modelId;
    
    BasicNaviController *navi = [[BasicNaviController alloc] initWithRootViewController:view];
    
    [self.ViewController presentViewController:navi animated:YES completion:^{
        
    }];
}

#pragma mark - UItableViewDataSource UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _heightArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.row) {
        case 0:
            return [self firstCell];
            break;
        case 1:
            return [self secondCell];
            break;
        case 2:
            return [self thirdCell];
            break;
        case 3:
            return [self forthCell];
            break;
        case 4:
            return [self fifthCell];
            break;
        case 5:
            return [self sixthCell];
            break;
        case 6:
            return [self seventhCell];
            break;
        case 7:
            return [self eighthCell];
            break;
        case 8:
            return [self ninethCell];
            break;
            
        default:
            break;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.backgroundColor = [UIColor colorWithRed:randColorNumber green:randColorNumber blue:randColorNumber alpha:1];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    UIView *cell = [[UIView alloc] init];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.tag = 200;
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 60, 30)];

    _textField.delegate = self;
    _textField.backgroundColor = [UIColor grayColor];
    _textField.text = @"🔍搜索菜谱、专辑、豆友";
    _textField.textColor = [UIColor whiteColor];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor whiteColor]);
    _textField.tag = 300;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_textField.frame) + 10, 10, 30, 30)];
    
    [button setBackgroundImage:[UIImage imageNamed:@"btn_header_function"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showFunctions:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:_textField];
    [cell addSubview:button];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat height = [_heightArray[indexPath.row] floatValue];
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

#pragma mark - UITexeFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    HomeSearchViewController *homeSearch = [[HomeSearchViewController alloc] init];
    [self.ViewController presentViewController:homeSearch animated:NO completion:NULL];
}

#pragma mark - UIScrollViewDelegate 

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){

    //NSLog(@"%@ %@", NSStringFromCGPoint(velocity), NSStringFromCGPoint(*targetContentOffset));
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

//    NSLog(@"%f", scrollView.contentOffset.y);
//
//    UITableViewCell *cell = [scrollView viewWithTag:200];
//    UIView *view = [cell viewWithTag:300];
//    
//    CGFloat y = scrollView.contentOffset.y;
//    
////    if (y < 0) {
////        self.tableHeaderView.alpha = (50 + y) / 50.0;
////    }else
//    if (y > 0 && y < 50){
////        cell.backgroundColor = [UIColor clearColor];
////        //CGFloat newY = 50 - y ? 50 - y : 50;
////        
////        //cell.alpha = (y - 50) / 50.0;
////        //NSLog(@"%f", cell.alpha);
////        
////        view.backgroundColor = [UIColor blackColor];
//        
//    }
//        else if(y > 50 && y < 250){
//        cell.backgroundColor = [UIColor whiteColor];
//        cell.alpha = (y - 50) / 200;
//        
//        view.backgroundColor = [UIColor grayColor];
//    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
