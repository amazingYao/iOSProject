//
//  YKWebViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/28.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKWebViewController.h"
#import "YKUIWebViewViewController.h"
#import "YKWKwebViewViewController.h"
@interface YKWebViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableV;
@end

@implementation YKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleIS:@"webView"];
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
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"UIWebView";
    }else{
         cell.textLabel.text = @"WKWebView";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = 0;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        YKUIWebViewViewController *vc = [[YKUIWebViewViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        YKWKwebViewViewController *vc = [[YKWKwebViewViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)dealloc{
    NSLog(@"webView页面销毁了");
}

@end
