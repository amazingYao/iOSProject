//
//  YKLBViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/12/3.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKLBViewController.h"
#import "YKImageLBViewController.h"
#import "YKTextLBViewController.h"
@interface YKLBViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableV;
@end

@implementation YKLBViewController
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self titleIS:@"轮播图"];
    self.tableV.backgroundColor = kWhiteColor;
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.rowHeight = 50;
    [self.tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableV];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.offset(NavBar_Height);
    }];
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (indexPath.row == 0) {
          cell.textLabel.text = [NSString stringWithFormat:@"%ld.图片轮播",indexPath.row + 1];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%ld.文字轮播",indexPath.row + 1];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = 0;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        YKImageLBViewController *vc = [[YKImageLBViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        YKTextLBViewController *vc = [[YKTextLBViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
