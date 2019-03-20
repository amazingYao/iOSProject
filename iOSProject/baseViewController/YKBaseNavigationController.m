//
//  YKBaseNavigationController.m
//  baseFramework
//
//  Created by 姚凯 on 2018/11/22.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKBaseNavigationController.h"

@interface YKBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation YKBaseNavigationController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    return self;
}
//重写这个方法是为了能够拦截所有push进来的控制器
//@param viewController 即将push进来的控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //判断push进来的控制器不是跟控制器
    if(self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        //可以重新定义导航栏的左右图标
        UIButton *butn = [UIButton buttonWithType:0];
        butn.frame = CGRectMake(0, 0, 30, 30);
        [butn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [butn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:butn];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
}
- (void)back{
    [self popViewControllerAnimated:YES];
    
}
- ( BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ( gestureRecognizer == self.interactivePopGestureRecognizer ){
        if ( self.visibleViewController == [self.viewControllers objectAtIndex:0] )//让第一个子控制器侧滑时不产生作用
        {
            return NO;
        }
    }
    
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
