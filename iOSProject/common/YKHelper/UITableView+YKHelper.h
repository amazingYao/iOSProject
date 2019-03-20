//
//  UITableView+YKHelper.h
//  TableView方法
//
//  Created by 姚凯 on 2018/9/12.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (YKHelper)
#pragma mark - 刷新方法
/**
 刷新某一段
 */
- (void)reloadIndexSection:(NSInteger)section;

/**
 刷新某一段某一行
 */
- (void)reloadIndexSection:(NSInteger)section IndexRow:(NSInteger)row;

#pragma mark - 注册方法 注:想要使用者两个方法,需要保证重用标识符和类名相同
/**
 注册类单元格
 */
- (void)zy_registNibCell:(Class)aClass;
/**
 注册带xib单元格
 */
- (void)zy_registClassCell:(Class)aClass;

@end
