//
//  YKCollectionViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/29.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKCollectionViewController.h"
#import "YKCollectionViewVViewController.h"
#import "YKCollectionHViewController.h"
@interface YKCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation YKCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleIS:@"CollectionView"];
    [self getData];
}
-(void)getData{
    self.dataArr = [NSMutableArray arrayWithObjects:@"上下滑动",@"左右滑动", nil];
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
        YKCollectionViewVViewController *vc = [[YKCollectionViewVViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        YKCollectionHViewController *vc = [[YKCollectionHViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
