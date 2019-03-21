//
//  YKExTabbarViewController.m
//  baseFramework
//
//  Created by 姚凯 on 2018/4/27.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import "YKExTabbarViewController.h"
#import "YKTabBar.h"

#import "YKHomeViewController.h"
#import "YKTabTwoViewController.h"
#import "YKThreeViewController.h"

#import "YKBaseNavigationController.h"
@interface YKExTabbarViewController ()

@end

@implementation YKExTabbarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setGolbalAppearance];
    [self setupAllChild];
    [self setupTabBar];
    
}
-(void)setupTabBar{
    [self setValue:[[YKTabBar alloc] init] forKeyPath:@"tabBar"];
}
-(void)setupAllChild{
    [self setChildViewControllerWithNavi:[[YKHomeViewController alloc]init] title:@"视图" image:@"com_tab_bt1_normal" selectImage:@"com_tab_bt1_select"];
    [self setChildViewControllerWithNavi:[[YKTabTwoViewController alloc]init] title:@"功能" image:@"com_tab_bt1_normal" selectImage:@"com_tab_bt1_select"];
    [self setChildViewControllerWithNavi:[[YKThreeViewController alloc]init] title:@"SDK" image:@"com_tab_bt1_normal" selectImage:@"com_tab_bt1_select"];
//    [self setChildViewControllerWithNavi:[[ZBCollectionViewController alloc]init] title:@"我的" image:@"tab_icon4" selectImage:@"tab_icon4_selected"];
}

/**
 设置tabbar文字
 */
-(void)setGolbalAppearance{
    UITabBarItem *item = [UITabBarItem appearance];
    //未选中状态
    NSMutableDictionary* normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    normalAttrs[NSForegroundColorAttributeName]=[UIColor lightGrayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    //选中状态 28 180 220
    NSMutableDictionary* selectDic=[NSMutableDictionary dictionary];
    selectDic[NSForegroundColorAttributeName]=[UIColor redColor];
    
    [item setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
}
//初始化子控制器 有导航栏
-(void)setChildViewControllerWithNavi:(UIViewController*)vc title:(NSString*)title image:(NSString*)image selectImage:(NSString*)selectedImage{
    vc.tabBarItem.title =title;
    vc.tabBarItem.image=[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    YKBaseNavigationController* navi = [[YKBaseNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:navi];
    
}
//初始化子控制器 无导航栏
-(void)setChildViewController:(UIViewController*)vc title:(NSString*)title image:(NSString*)image selectImage:(NSString*)selectedImage{
    vc.tabBarItem.title =title;
    vc.tabBarItem.image=[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:vc];
}




@end
