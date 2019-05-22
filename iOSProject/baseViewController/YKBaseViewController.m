//
//  YKBaseViewController.m
//  baseFramework
//
//  Created by 姚凯 on 2018/4/25.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import "YKBaseViewController.h"

@interface YKBaseViewController ()

@end

@implementation YKBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = RGB(50, 180, 222);
}

#pragma mark - 导航栏 标题 左右barButtonItem 重定义方法
- (void)titleIS:(NSString *)title
{
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    [customLab setTextColor:kWhiteColor];
    [customLab setText:title];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
    customLab.centerX = SCREEN_WIDTH/2;
    customLab.y = 5;
}

- (void)setNavigationRightBarButtonWithImage:(NSString *)imag
{
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setImage:[UIImage imageNamed:imag] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setNavigationRightBarButtonWithString:(NSString *)str
{
    UIButton *publishBtn = [UIButton buttonWithType:0];
    publishBtn.frame = CGRectMake(0, 0, 40, 25);
    [publishBtn setTitle:str forState:UIControlStateNormal];
    publishBtn.titleLabel.font = TextFont(15);
    publishBtn.backgroundColor = [UIColor clearColor];
    [publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(rightBAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:publishBtn];
}

- (void)setNavigationLeftBarButtonWithString:(NSString *)str
{
    UIButton *publishBtn = [UIButton buttonWithType:0];
    publishBtn.frame = CGRectMake(0, 0, 40, 25);
    [publishBtn setTitle:str forState:UIControlStateNormal];
    publishBtn.titleLabel.font = TextFont(15);
    publishBtn.backgroundColor = [UIColor clearColor];
    [publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(leftBAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:publishBtn];
}

- (void)setNavigationLeftBarButtonWithImage:(NSString *)imag
{
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setImage:[UIImage imageNamed:imag] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftBAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)rightBAction
{
    
}

- (void)leftBAction
{
    
}

@end
