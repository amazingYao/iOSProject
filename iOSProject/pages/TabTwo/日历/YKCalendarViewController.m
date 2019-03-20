//
//  YKCalendarViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2019/3/20.
//  Copyright © 2019 姚凯. All rights reserved.
//

#import "YKCalendarViewController.h"

@interface YKCalendarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *dataA;

@end

@implementation YKCalendarViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleIS:@"日历"];
    [self setUp];
}
-(void)setUp{
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.offset(NavBar_Height);
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataA.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.dataA[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class class = NSClassFromString([NSString stringWithFormat:@"%@Controller",self.dataA[indexPath.row]]);
    [self.navigationController pushViewController:[class new] animated:YES];
    
}
-(UITableView *)tableview{
    
    if (!_tableview) {
        _tableview =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.tableFooterView = [UIView new];
        
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableview;
}

-(NSArray *)dataA{
    if (!_dataA) {
        _dataA = @[@"LXCalendarOne",@"LXCalendarTwo",@"LXCalendarThree",@"LXCalendarFour",@"LXCalendarFive",@"LXCalendarSix"];
    }
    return _dataA;
}

@end
