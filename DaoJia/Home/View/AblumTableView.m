//
//  AblumTableView.m
//  项目三首页
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "AblumTableView.h"
#import "RecipeViewController.h"
#import "BasicNaviController.h"

#define kFirstCellImageHeight 120
#define kAlbumTableViewCell @"albumTableViewCell"

@interface AblumTableView ()

@property (nonatomic, copy) NSArray *listArray;
@property (nonatomic, copy) NSDictionary *infoDic;

@end

@implementation AblumTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataDic = [NSDictionary dictionary];
        
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerNib:[UINib nibWithNibName:@"AlbumTableViewCell" bundle:NULL] forCellReuseIdentifier:kAlbumTableViewCell];
        
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic {

    if (_dataDic != dataDic) {
        _dataDic = dataDic;
        
        _listArray = dataDic[@"list"];
        _infoDic = dataDic[@"info"];
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1 + _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kFirstCellImageHeight)];
        view.clipsToBounds = YES;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -40, kScreenWidth, 180)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:_infoDic[@"AlbumCover"]]];
        
        [view addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, kScreenWidth - 60, 48)];
        
        titleLabel.font = [UIFont systemFontOfSize:19];
        titleLabel.text = _infoDic[@"AlbumTitle"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = [UIColor whiteColor];
        
        [view addSubview:titleLabel];
        
        CGRect rect = [_infoDic[@"AlbumUserName"] boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                        
                                                                                                                                        NSFontAttributeName : [UIFont systemFontOfSize:10]
                                                                                                                                        
                                                                                                                                        } context:nil];
        
        UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - rect.size.width / 2 - 17, CGRectGetMaxY(titleLabel.frame) + 5, 30 + rect.size.width + 5, 30)];
        
        UIImageView *userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        userIcon.layer.masksToBounds = YES;
        userIcon.layer.cornerRadius = userIcon.width / 2;
        
        [userIcon sd_setImageWithURL:[NSURL URLWithString:_infoDic[@"AlbumAvatarUrl"]]];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, rect.size.width, 10)];
        
        nameLabel.text = _infoDic[@"AlbumUserName"];
        nameLabel.font = [UIFont systemFontOfSize:10];
        nameLabel.textColor = [UIColor whiteColor];
        
        [control addSubview:userIcon];
        [control addSubview:nameLabel];
        [view addSubview:control];
        
        WXLabel *albumContentLabel = [[WXLabel alloc] init];
        albumContentLabel.linespace = kLineSpace;
        albumContentLabel.font = [UIFont systemFontOfSize:kTextHeight];
        albumContentLabel.text = _infoDic[@"AlbumContent"];
        
        CGFloat height = [WXLabel getTextHeight:kTextHeight width:kScreenWidth - 20 text:_infoDic[@"AlbumContent"] linespace:kLineSpace];
        
        albumContentLabel.frame = CGRectMake(10, CGRectGetMaxY(view.frame) + 10, kScreenWidth - 20, height);
        
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 110 + 20 + height)];
        
        [cell addSubview:view];
        [cell addSubview:albumContentLabel];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    AlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAlbumTableViewCell forIndexPath:indexPath];
    
    NSDictionary *dic = [_listArray objectAtIndex:indexPath.row - 1];
    
    cell.model = [[ListModel alloc] initContentWithDic:dic];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

//    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    
//    cell.backgroundColor = [UIColor colorWithRed:randColorNumber green:randColorNumber blue:randColorNumber alpha:1];
//    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CGFloat height = [WXLabel getTextHeight:kTextHeight width:kScreenWidth - 20 text:_infoDic[@"AlbumContent"] linespace:kLineSpace];

        return height + kFirstCellImageHeight + 20;
    }
    
    ListModel *model = [[ListModel alloc] initContentWithDic:[_listArray objectAtIndex:indexPath.row - 1]];
    
    CGFloat height = [WXLabel getTextHeight:kTextHeight width:kScreenWidth - 20 text:model.intro linespace:kLineSpace];
    
    return 150 + height + 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row > 0) {
        
        ListModel *model = [[ListModel alloc] initContentWithDic:[_listArray objectAtIndex:indexPath.row - 1]];

        RecipeViewController *view = [[RecipeViewController alloc] init];
        
        view.recipeID = model.recipeID;
        
        BasicNaviController *navi = [[BasicNaviController alloc] initWithRootViewController:view];
        
        [self.ViewController presentViewController:navi animated:YES completion:^{
            
        }];
        
    }

}

@end
