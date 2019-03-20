//
//  YKZWViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/27.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKZWViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface YKZWViewController ()

@end

@implementation YKZWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleIS:@"指纹解锁"];
    [self initUI];
}

-(void)initUI{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"点击验证指纹" forState:UIControlStateNormal];
    [btn setTintColor:kWhiteColor];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.offset(NavBar_Height);
        make.height.equalTo(@(100));
    }];
}

-(void)btnClick{
    LAContext *context = [LAContext new];
    //这个属性是设置指纹输入失败之后的弹出框的选项
    context.localizedFallbackTitle = @"输入密码";
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        NSLog(@"支持指纹识别");
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请验证指纹？" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [YKAlter makeTost:@"验证成功" View:self.view];
                }];
                NSLog(@"验证成功 刷新主界面");
            }else{
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"系统取消授权，如其他APP切入");
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        NSLog(@"用户取消验证Touch ID");
                        break;
                    }
                    case LAErrorAuthenticationFailed:
                    {
                        NSLog(@"授权失败");
                        break;
                    }
                    case LAErrorPasscodeNotSet:
                    {
                        NSLog(@"系统未设置密码");
                        break;
                    }
                    case LAErrorTouchIDNotAvailable:
                    {
                        NSLog(@"设备Touch ID不可用，例如未打开");
                        break;
                    }
                    case LAErrorTouchIDNotEnrolled:
                    {
                        NSLog(@"设备Touch ID不可用，用户未录入");
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"用户选择输入密码，切换主线程处理");
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"其他情况，切换主线程处理");
                        }];
                        break;
                    }
                }
            }
        }];
    }else{
        NSLog(@"不支持指纹识别");
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
    }

}

-(void)dealloc{
    NSLog(@"指纹解锁页面销毁了");
}
@end
