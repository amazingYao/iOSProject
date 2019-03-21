//
//  YKSliderViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2019/3/21.
//  Copyright © 2019 姚凯. All rights reserved.
//

#import "YKSliderViewController.h"
#import "CircleViewController.h"
#import "CircleWithTextViewController.h"
#import "SemiCircleViewController.h"
#import "SemiCircleWithTextViewController.h"

@interface YKSliderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableV;
@end

@implementation YKSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleIS:@"进度条"];
    [self.view addSubview:self.tableV];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.offset(NavBar_Height);
    }];
}

#pragma mark - tableView
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableV.backgroundColor = kWhiteColor;
        _tableV.dataSource = self;
        _tableV.delegate = self;
        _tableV.rowHeight = 50;

    }
    return _tableV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
            if (indexPath.row == 0) {
                cell.textLabel.text = @"环形显示的进度条";
            }else if (indexPath.row == 1){
                cell.textLabel.text = @"环形显示的进度条——文字";
            }else if (indexPath.row == 2){
                cell.textLabel.text = @"弧形显示的进度条";
            }else if (indexPath.row == 3){
                cell.textLabel.text = @"弧形显示的进度条——文字";
            }else if (indexPath.row == 4){
                cell.textLabel.text = @"水平显示的进度条";
            }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

        if (indexPath.row == 0) {
            CircleViewController *circle = [[CircleViewController alloc] init];
            [self.navigationController pushViewController:circle animated:YES];
        }else if (indexPath.row == 1){
            CircleWithTextViewController *circleWithText = [[CircleWithTextViewController alloc] init];
            [self.navigationController pushViewController:circleWithText animated:YES];
        }else if (indexPath.row == 2){
            SemiCircleViewController *semiCircle = [[SemiCircleViewController alloc] init];
            [self.navigationController pushViewController:semiCircle animated:YES];
        }else if (indexPath.row == 3){
            SemiCircleWithTextViewController *semiCircleWithText = [[SemiCircleWithTextViewController alloc] init];
            [self.navigationController pushViewController:semiCircleWithText animated:YES];
        }
}


@end
