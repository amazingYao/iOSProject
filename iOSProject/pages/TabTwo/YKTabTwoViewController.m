//
//  YKTabTwoViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/26.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKTabTwoViewController.h"
#import "YKZWViewController.h"
#import "YKKZViewController.h"
#import "YK3DTouchViewController.h"
#import "YKFileViewController.h"
#import "YKAdressBookViewController.h"
#import "YKTakePhotoViewController.h"
#import "YKCalendarViewController.h"
@interface YKTabTwoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSArray *dataArr;

@end

@implementation YKTabTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleIS:@"功能"];
    [self getData];
}
-(void)getData{
    self.dataArr = @[@"3DTouch",@"指纹解锁",@"Today Widget 扩展",@"健康",@"通讯录",@"相册",@"文件预览",@"日历"];
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
    if (indexPath.row == 0) {
        YK3DTouchViewController *vc = [[YK3DTouchViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        YKZWViewController *vc = [[YKZWViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        YKKZViewController *vc = [[YKKZViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){
       
    }else if (indexPath.row == 4){
        YKAdressBookViewController *vc = [[YKAdressBookViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 5){
        YKTakePhotoViewController *vc = [[YKTakePhotoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 6){
        YKFileViewController *vc = [[YKFileViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 7){
        YKCalendarViewController *vc = [[YKCalendarViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
