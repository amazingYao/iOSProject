//
//  YKResetViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2019/5/22.
//  Copyright © 2019 姚凯. All rights reserved.
//

#import "YKResetViewController.h"
#import "YKExTabbarViewController.h"


@interface YKResetViewController ()

@end

@implementation YKResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self titleIS:@"修改RootView"];
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"修改RootView" forState:UIControlStateNormal];
    button.titleLabel.font = TextFont(20);
    [button setTitleColor:RGB(150,145,169) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

-(void)clickBtn{

    
    // persent 的页面 必须先使用diss方法，然后再进行修改。否则会造成内存泄漏
    
    [self dismissViewControllerAnimated:NO completion:^{
        YKExTabbarViewController *vc = [[YKExTabbarViewController alloc] init];
        kKeyWindow.rootViewController = vc;
        [kKeyWindow makeKeyAndVisible];
    }];
    
    
    /** 导航栏push的页面直接修改即可
     
    YKExTabbarViewController *vc = [[YKExTabbarViewController alloc] init];
    kKeyWindow.rootViewController = vc;
    [kKeyWindow makeKeyAndVisible];
     
     */
}

@end
