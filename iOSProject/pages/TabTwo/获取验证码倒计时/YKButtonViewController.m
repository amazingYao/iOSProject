//
//  YKButtonViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2019/3/21.
//  Copyright © 2019 姚凯. All rights reserved.
//

#import "YKButtonViewController.h"
#import "WLCaptcheButton.h"

@interface YKButtonViewController ()

@end

@implementation YKButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self titleIS:@"倒计时按钮"];
    
    WLCaptcheButton *button = [[WLCaptcheButton alloc] init];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@150);
    }];
    button.disabledTitleColor = [UIColor whiteColor];
    button.disabledBackgroundColor = [UIColor grayColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)buttonClick:(WLCaptcheButton *)sender{
    NSLog(@"%@", sender.identifyKey);
    [sender fire];
}

@end
