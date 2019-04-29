//
//  YKTabTwoViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/26.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKTabTwoViewController.h"

@interface YKTabTwoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) NSArray *viewArr;
@end

@implementation YKTabTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleIS:@"扩展"];
    [self getData];
}
-(void)getData{
    self.dataArr = @[@"3DTouch",@"指纹解锁",@"Today Widget 扩展",@"健康",@"通讯录",@"相册",@"文件预览",@"日历",@"3DES",@"倒计时按钮"];
    self.viewArr = @[@"3DTouch",@"ZW解锁",@"KZ",@"",@"AdressBook",@"TakePhoto",@"File",@"Calendar",@"3DES",@"Button"];
    [self.tableV reloadData];
}

#pragma mark - tableView
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TabBar_Height) style:UITableViewStylePlain];
        _tableV.backgroundColor = kWhiteColor;
        _tableV.dataSource = self;
        _tableV.delegate = self;
        _tableV.rowHeight = 50;
        [_tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:self.tableV];
    }
    
    return _tableV;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld.%@",indexPath.row + 1,self.dataArr[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = 0;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Class class = NSClassFromString([NSString stringWithFormat:@"YK%@ViewController",self.viewArr[indexPath.row]]);
    [self.navigationController pushViewController:[class new] animated:YES];
    
}

@end
