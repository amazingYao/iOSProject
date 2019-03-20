//
//  YKKZViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/27.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKKZViewController.h"
#import "YKKZNetModel.h"
#import "YKKZModel.h"
#import "YKKZTableViewCell.h"
@interface YKKZViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSMutableArray *dataArr;


/** 数据业务逻辑层 */
@property (nonatomic,strong)YKKZNetModel *netModel;
@end

@implementation YKKZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleIS:@"Today扩展"];
    _netModel = [[YKKZNetModel alloc] init];
    _netModel.fatherView = self.view;
    _netModel.viewController = self;
    self.dataArr = [[NSMutableArray alloc] init];
    [self getData];
    

}
-(void)getData{
    [_netModel requestGetHotNovel:^(NSArray *array) {
        for (NSData *modelData in array) {
            YKKZModel *model = [YKKZModel mj_objectWithKeyValues:modelData];
            [self.dataArr addObject:model];
        }
        
        NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.YKTodayGroup"];
        [defaults setObject:array forKey:@"TodayKey"];
        [self.tableV reloadData];
    }];

}

#pragma mark - tableView
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableV.backgroundColor = kWhiteColor;
        _tableV.dataSource = self;
        _tableV.delegate = self;
        _tableV.rowHeight = 100;
        [_tableV zy_registNibCell:[YKKZTableViewCell class]];
        [self.view addSubview:self.tableV];
    }
    return _tableV;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YKKZTableViewCell *cell = [self.tableV dequeueReusableCellWithIdentifier:@"YKKZTableViewCell" forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    cell.selectionStyle = 0;
    return cell;
}

-(void)dealloc{
    NSLog(@"Today扩展销毁了");
}

@end
