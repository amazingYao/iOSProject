//
//  YKTableViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/28.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKTableViewController.h"
#import "YKTableViewCell.h"
@interface YKTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableV;
@end

@implementation YKTableViewController
#pragma lazy
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:1];
    }
    return _tableV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleIS:@"TableView"];
    [self initUI];
}


#pragma mark - UI
-(void)initUI{
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.backgroundColor = kWhiteColor;
    //取消tableView下划线
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    //取消滚动条
    self.tableV.showsVerticalScrollIndicator = NO;
    [self.tableV zy_registNibCell:[YKTableViewCell class]];
    
    //适配iOS11 尤其在使用MJRefresh时需要加上
    self.tableV.estimatedRowHeight = 0;
    self.tableV.estimatedSectionHeaderHeight = 0;
    self.tableV.estimatedSectionFooterHeight = 0;

    __weak __typeof__(self) weakSelf = self;
//    //下拉刷新
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getData1];
    }];
    // 马上进入刷新状态
//    [self.tableV.mj_header beginRefreshing];
    
    //上拉刷新
    self.tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
         [weakSelf getData2];
    }];
    
    
    //页面显示有bug
    //自动回弹上拉
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    self.tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getData2)];
//    // 设置了底部inset
//    self.tableV.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
//    // 忽略掉底部inset
//    self.tableV.mj_footer.ignoredScrollViewContentInsetBottom = 0;
    
    
    [self.view addSubview:self.tableV];
    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.offset(NavBar_Height);
    }];
}
-(void)getData1{
    __weak __typeof__(self) weakSelf = self;
    [YKAlter show:@"正在加载"];
    [YKHttp getRequestWithURLStr:@"https://www.apiopen.top/novelApi" params:nil success:^(NSDictionary *responseDic) {
        [weakSelf.tableV.mj_header endRefreshing];
        [YKAlter dismiss];
    } failure:^(NSError *error) {
        [YKAlter dismiss];
        [weakSelf.tableV.mj_header endRefreshing];
    }];
}
-(void)getData2{
    __weak __typeof__(self) weakSelf = self;
    [YKAlter show:@"正在加载"];
    [YKHttp getRequestWithURLStr:@"https://www.apiopen.top/novelApi" params:nil success:^(NSDictionary *responseDic) {
        [weakSelf.tableV.mj_footer endRefreshing];
//        [weakSelf.tableV.mj_footer setHidden:YES];
        [YKAlter dismiss];
    } failure:^(NSError *error) {
        [YKAlter dismiss];
        [weakSelf.tableV.mj_footer endRefreshing];
    }];
}

#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YKTableViewCell *cell = [_tableV dequeueReusableCellWithIdentifier:@"YKTableViewCell" forIndexPath:indexPath];
    //取消tableView点击选中状态
    cell.selectionStyle = 0;
    cell.tittleLab.text = [NSString stringWithFormat:@"这是第%ld分区",indexPath.section+1];
    cell.subTittle.text = [NSString stringWithFormat:@"这是第%ld行",indexPath.row+1];
    [YKHelper namedImageView:cell.ImgV With:[NSString stringWithFormat:@"dota-%ld",indexPath.section%5+1]];

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //每行高度
    return SCREEN_HEIGHT/10;
}

//头试图与脚试图 如果不需要头试图与脚试图的悬停功能 需要将tableView的style设置为grouped
//并且此时如果只需要其中一个试图，也需要将另外一个试图的高度设为一个很小的数值（不可为0） 否则会有空白
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/15)];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/15)];
    lab.text = [NSString stringWithFormat:@"----我是第%ld分区的header呀---",(long)section+1];
    lab.textAlignment = NSTextAlignmentCenter;
    [header addSubview:lab];
    header.backgroundColor = [UIColor blueColor];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SCREEN_HEIGHT/15;
}

//脚试图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/20)];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/20)];
    lab.text = [NSString stringWithFormat:@"----我是第%ld分区的footer呀---",(long)section+1];
    lab.textAlignment = NSTextAlignmentCenter;
    [footer addSubview:lab];
    footer.backgroundColor = [UIColor brownColor];

    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     return SCREEN_HEIGHT/20;
//     return CGFLOAT_MIN;
}


-(void)dealloc{
    NSLog(@"TableView销毁了");
}
@end
