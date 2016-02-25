//
//  PeopleTableView.m
//  好豆菜谱ZN
//
//  Created by Macx on 16/2/22.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "PeopleTableView.h"
#import "PeopleCell.h"
#import "TopModel.h"


@implementation PeopleTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        //初始化设置
        self.delegate = self;
        self.dataSource = self;
//        self.separatorStyle = UITableViewCellSelectionStyleGray;
        //        [self registerClass:[TopicCell class] forCellReuseIdentifier:@"cell"];
        
        self.separatorStyle = UITableViewCellAccessoryNone;
        
//        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerNib:[UINib nibWithNibName:@"PeopleCell" bundle:nil] forCellReuseIdentifier:@"people"];
//        [self registerNib:[UINib nibWithNibName:@"GroundCell" bundle:nil] forCellReuseIdentifier:@"ground"];
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        self.tableFooterView = footView;
        
    }
    return self;
    
    
}

#pragma -mark  表示图代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    NSArray *arr = [_dataDictionary objectForKey:@"list"];
    return arr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *arr = [_dataDictionary objectForKey:@"list"];
    PeopleCell *cell = [self dequeueReusableCellWithIdentifier:@"people"];
    cell.model = [[TopModel alloc] initContentWithDic:[arr objectAtIndex:indexPath.row]];
    cell.peopleModel = [[PeopleModel alloc] initContentWithDic: [[arr objectAtIndex:indexPath.row] objectForKey:@"CommonInfo"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 145;
}
//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextFillRect(context, rect);
//    
//    //上分割线，
////    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"ffffff"].CGColor);
////    CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
//    
//    //下分割线
////    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"e2e2e2"].CGColor);
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
//    CGContextStrokeRect(context, CGRectMake(5, rect.size.height, rect.size.width - 10, 30));
//}


@end
