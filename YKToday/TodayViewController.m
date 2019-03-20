//
//  TodayViewController.m
//  YKToday
//
//  Created by 姚凯 on 2018/11/27.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "YKKZModel.h"
#import "YKTodayTableViewCell.h"
#import "UITableView+YKHelper.h"
#import "MJExtension.h"
@interface TodayViewController () <NCWidgetProviding,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UITableView *tableV;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self getData];
}

-(void)getData{
    self.dataArr = [[NSMutableArray alloc] init];;
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.YKTodayGroup"];
    NSArray *dataArr = [defaults objectForKey:@"TodayKey"];
    for (NSData *modelData in dataArr) {
         YKKZModel *model = [YKKZModel mj_objectWithKeyValues:modelData];
        [self.dataArr addObject:model];
    }
    [self.tableV reloadData];
}


-(void)initUI{
    //支持折叠和展开
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
}

//设置折叠和展开显示区域
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize{
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        self.preferredContentSize = maxSize;
    } else if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        self.preferredContentSize = CGSizeMake(0, 440);
    }
}

#pragma mark - tableView
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableV.backgroundColor = [UIColor whiteColor];
        _tableV.dataSource = self;
        _tableV.delegate = self;
        _tableV.rowHeight = 110;
        [_tableV registerNib:[UINib nibWithNibName:NSStringFromClass([YKTodayTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([YKTodayTableViewCell class])];
        [self.view addSubview:self.tableV];
    }
    return _tableV;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YKTodayTableViewCell *cell = [self.tableV dequeueReusableCellWithIdentifier:@"YKTodayTableViewCell" forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    cell.selectionStyle = 0;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *str = [NSString stringWithFormat:@"iOSProject://%ld", (long)indexPath.row];
    [self.extensionContext openURL:[NSURL URLWithString:str] completionHandler:nil];
}





- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
