//
//  YKScrollerViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/30.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKScrollerViewController.h"

@interface YKScrollerViewController ()

@end

@implementation YKScrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    [self titleIS:@"ScrollerView"];
    
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIView * container = [UIView new];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    UIView * redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:redView];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(scrollView);
        make.height.mas_equalTo(600);
    }];
    
    UIView * blueView = [UIView new];
    blueView.backgroundColor = [UIColor blueColor];
    [scrollView addSubview:blueView];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(redView.mas_bottom);
        make.left.right.equalTo(scrollView);
        make.height.mas_equalTo(400);
        make.bottom.equalTo(container);
    }];

//    UILabel *lab = [[UILabel alloc] init];
//    lab.numberOfLines = 0;
//    [blueView addSubview:lab];
//    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.offset(0);
//        make.bottom.equalTo(container);
//    }];
//    lab.text = @"1231231231231231231231231231231231231231231231231231231231231";
    
    
    
    
}
-(void)dealloc{
    NSLog(@"scrollerView销毁了");
}
@end
