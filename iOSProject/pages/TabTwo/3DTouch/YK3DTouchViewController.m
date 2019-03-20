//
//  YK3DTouchViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/28.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YK3DTouchViewController.h"
#import "YK3DTouchShowViewController.h"
@interface YK3DTouchViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableV;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation YK3DTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleIS:@"3DTouch"];
    [self getData];
}

-(void)getData{
    _dataArr = [NSMutableArray array];
    for (int i = 1; i <= 30; i++) {
        [_dataArr addObject:@(i)];
    }
    [self.tableV reloadData];
}
#pragma mark - tableView
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
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
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"第%@行",self.dataArr[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = 0;
    
    //注册3D Touch
    /**
     从iOS9开始，我们可以通过这个类来判断运行程序对应的设备是否支持3D Touch功能。
     UIForceTouchCapabilityUnknown = 0,     //未知
     UIForceTouchCapabilityUnavailable = 1, //不可用
     UIForceTouchCapabilityAvailable = 2    //可用
     */
    
    if ([self respondsToSelector:@selector(traitCollection)]) {
        if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
            if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
                [self registerForPreviewingWithDelegate:(id)self sourceView:cell];
            }
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YK3DTouchShowViewController *vc = [[YK3DTouchShowViewController alloc] init];
    vc.strInfo = [NSString stringWithFormat:@"第%@行",self.dataArr[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 3DTouch
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location NS_AVAILABLE_IOS(9_0) {
    NSIndexPath *indexPath = [self.tableV indexPathForCell:(UITableViewCell *)[previewingContext sourceView]];
    NSString *str = [NSString stringWithFormat:@"第%@行",self.dataArr[indexPath.row]];
    
    //创建要预览的控制器
    YK3DTouchShowViewController *vc = [[YK3DTouchShowViewController alloc] init];
    vc.strInfo = str;
    
    //指定当前上下文视图Rect
    //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面）
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width,50);
    previewingContext.sourceRect = rect;
   
    return vc;
}


//从预览层直接进入下个页面
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit NS_AVAILABLE_IOS(9_0) {
    [self showViewController:viewControllerToCommit sender:self];
}


-(void)dealloc{
    NSLog(@"3DTouch页面销毁");
}

@end
