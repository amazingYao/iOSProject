//
//  YKHomeViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/23.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKHomeViewController.h"
#import "DHGuidePageHUD.h"
#import "YKWebViewController.h"
#import "YKTableViewController.h"
#import "YKCollectionViewController.h"
#import "YKScrollerViewController.h"
#import "YKLBViewController.h"


@interface YKHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate>
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation YKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStaticGuidePage];
    [self initUI];
    [self getData];
}

-(void)initUI{
     [self titleIS:@"首页"];
    self.tabBarController.delegate = self;
}

-(void)getData{
    self.dataArr = [NSMutableArray arrayWithObjects:@"tableView",@"collectionView",@"scrollerView",@"webView",@"轮播图", nil];
     [self.tableV reloadData];
}
#pragma mark - 设置APP静态图片引导页
- (void)setStaticGuidePage {
    NSString *currentVersion = [YKSystem getCurrentVersion];
    NSString *showedVersion = [YKUser getStringDataFromUserDefaults:@"firstInVersion" default:nil];
    if (![currentVersion isEqualToString:showedVersion]) {
        [YKUser putStringDataToUserDefaults:@"firstInVersion" value:currentVersion];
        NSArray *imageNameArray = @[@"image2.jpg",@"image3.jpg",@"image4.jpg",@"image5.jpg"];
        DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) imageNameArray:imageNameArray buttonIsHidden:NO];
        guidePage.slideInto = YES;
        [self.tabBarController.view addSubview:guidePage];
    }
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
        YKTableViewController *vc = [[YKTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        YKCollectionViewController *vc = [[YKCollectionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        YKScrollerViewController *vc = [[YKScrollerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];         
    }else if (indexPath.row == 3){
        YKWebViewController *vc = [[YKWebViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 4){
        YKLBViewController *vc = [[YKLBViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}



#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    // 判断哪个界面要需要再次点击刷新，这里以第一个VC为例
    if ([tabBarController.selectedViewController isEqual:[tabBarController.viewControllers firstObject]]) {
        // 判断再次选中的是否为当前的控制器
        if ([viewController isEqual:tabBarController.selectedViewController]) {
            // 执行操作
            NSLog(@"刷新界面");
            return NO;
        }
    }
    return YES;
}

@end
