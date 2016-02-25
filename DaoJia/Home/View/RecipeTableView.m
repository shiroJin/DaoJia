//
//  RecipeTableView.m
//  项目三首页
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 jagain. All rights reserved.
//

#import "RecipeTableView.h"

@interface RecipeTableView ()

@property (nonatomic, copy) NSArray *heightArr;

@end

@implementation RecipeTableView

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
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];

    cell.backgroundColor = [UIColor colorWithRed:randColorNumber green:randColorNumber blue:randColorNumber alpha:1];


    return cell;
}


@end
