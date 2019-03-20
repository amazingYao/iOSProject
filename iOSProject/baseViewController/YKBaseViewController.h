//
//  YKBaseViewController.h
//  baseFramework
//
//  Created by 姚凯 on 2018/4/25.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKBaseViewController : UIViewController
#pragma mark - 导航栏 标题 左右barButtonItem 重定义方法
- (void)titleIS:(NSString *)title;
- (void)setNavigationRightBarButtonWithImage:(NSString *)imag;
- (void)setNavigationRightBarButtonWithString:(NSString *)str;
- (void)setNavigationLeftBarButtonWithImage:(NSString *)imag;
- (void)setNavigationLeftBarButtonWithString:(NSString *)str;



- (void)leftBAction;
- (void)rightBAction;


@end
